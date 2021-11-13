import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/function/date.dart';

class CashierPage extends StatelessWidget {
  final Transaction transaction;
  const CashierPage({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.red,
                  width: size.width * 0.8,
                  child: Card(
                    child: Row(
                      children: [
                        Text(order.name),
                        Text(order.subtotal().toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
            Text(
              'Total: ' + data.grandtotal().toString(),
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }
}
