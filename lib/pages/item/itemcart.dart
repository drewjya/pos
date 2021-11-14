import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/boxes.dart';
import 'package:pos/database/orderlist.dart';
import 'package:pos/database/product.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/pages/cashier/cashier_page.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({Key? key}) : super(key: key);

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  int _currentCount = 0;
  List<OrderList> currOrder = [];
  addOrder(Product product, int index) {
    OrderList curr = OrderList(
      idproduct: product.idproduct,
      name: product.name,
      price: product.harga,
      qty: 1,
      capital: product.hargaModal,
    );
    bool count = false;
    for (OrderList item in currOrder) {
      if (item.idproduct == product.idproduct) {
        item.qty += 1;
        count = true;
        break;
      }
    }
    if (!count) {
      currOrder.add(curr);
    }
    _update();
  }

  void _update() {
    setState(() {
      _currentCount = currOrder.length;
    });
  }

  Transaction addToTransaction(List<OrderList> order) {
    List<double> sub = [];
    List<double> prov = [];
    for (var item in order) {
      sub.add(item.subtotal());
      prov.add(item.profit());
    }
    List<Map<String, dynamic>> orderL = [];

    for (var item in order) {
      orderL.add(item.toJson());
    }
    return Transaction(
      idtrans: 'TRX${order.length}${DateTime.now().hashCode}',
      subtotal: sub,
      orderList: orderL,
      date: DateTime.now(),
      profit: prov,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: Boxes.getProduct().listenable(),
        builder: (context, box, _) {
          final product = box.values.toList().cast<Product>();
          if (product.isEmpty) {
            return const Center(
              child: Text(
                'No Product yet!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: product.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var current = product[index];
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                    decoration: BoxDecoration(
                      // color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Text(current.name),
                      subtitle: Text(current.harga.toStringAsFixed(2)),
                      trailing: Text("Stock: ${current.stock.toString()}"),
                      onTap: () => addOrder(current, index),
                      enabled: (current.stock <= 0) ? false : true,
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: (_currentCount != 0)
          ? FloatingActionButton.extended(
              onPressed: () {
                Transaction data = addToTransaction(currOrder);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CashierPage(
                            transaction: data,
                          )),
                );
              },
              label: Text(_currentCount.toString()),
              icon: const Icon(
                Icons.shopping_bag_rounded,
              ),
              elevation: 1,
            )
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.shopping_bag_rounded),
              elevation: 0,
            ),
    );
  }
}
