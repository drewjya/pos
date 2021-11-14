import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/product.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/function/date.dart';
import 'package:pos/pages/base.dart';

class CashierPage extends StatelessWidget {
  final Transaction transaction;
  const CashierPage({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<Product> product = Hive.box<Product>("product");
    doTransaction(Transaction data) {
      for (var orderList in data.orderList) {
        product.values
            .where((dataP) => dataP.idproduct == orderList.idproduct)
            .forEach((dataP) {
          dataP.stock -= orderList.qty;
          dataP.save();
        });
      }
    }

    Transaction data = transaction;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashier'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: size.width * 0.95,
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  data.idtrans,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Center(
              child: Container(
                width: size.width * 0.95,
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  toNormalDate(data.date),
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.orderList.length,
              itemBuilder: (context, index) {
                OrderList order = data.orderList[index];
                return Container(
                  width: size.width * 0.8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(
                      order.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      order.qty.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      order.subtotal().toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              'Total: ' + data.grandtotal().toStringAsFixed(2),
              textAlign: TextAlign.right,
            ),
            TextButton(
              onPressed: () {
                doTransaction(transaction);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const BasePage()));
              },
              child: SizedBox(
                width: size.width * 0.8,
                child: const Center(
                  child: Text(
                    'Bayar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
