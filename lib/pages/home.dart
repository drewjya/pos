import 'package:flutter/material.dart';
import 'package:pos/database/product.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/pages/cashier/cashier_page.dart';

class HomeCashier extends StatefulWidget {
  const HomeCashier({Key? key}) : super(key: key);

  @override
  State<HomeCashier> createState() => _HomeCashierState();
}

class _HomeCashierState extends State<HomeCashier> {
  int _currentCount = 0;
  List<Product> hahah = [
    Product(
      idproduct: '01',
      name: 'Pulpen',
      harga: 20000,
      hargaModal: 10000,
      stock: 20,
    ),
    Product(
      idproduct: '02',
      name: 'Kertas',
      harga: 23000,
      hargaModal: 12000,
      stock: 20,
    ),
  ];
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
    debugPrint(currOrder.length.toString());
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
    return Transaction(
      idtrans: 'TRX${order.length}${DateTime.now().hashCode}',
      subtotal: sub,
      orderList: order,
      date: DateTime.now(),
      profit: prov,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: hahah.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var current = hahah[index];
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      decoration: BoxDecoration(
                        // color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(current.name),
                        subtitle: Text(current.harga.toStringAsFixed(2)),
                        trailing: Text("Stock: ${current.stock.toString()}"),
                        onTap: () => addOrder(current, index),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
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
