import 'package:flutter/material.dart';
import 'package:pos/database/orderlist.dart';
import 'package:pos/database/transaction.dart';

class DetailTransaction extends StatelessWidget {
  final Transaction data;
  const DetailTransaction({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.idtrans),
        elevation: 0,
      ),
      body: ListView(children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: data.orderList.length,
          itemBuilder: (context, index) {
            final orderlist = OrderList.fromJson(data.orderList[index]);
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text("Product Name : "),
                      Text("Quantity : "),
                      Text("Subtotal : "),
                      Text("Profit : "),
                    ],
                  ),
                  Column(
                    children: [
                      Text(orderlist.name),
                      Text(orderlist.qty.toString()),
                      Text(orderlist.subtotal().toStringAsFixed(0)),
                      Text(orderlist.profit().toStringAsFixed(0)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Grand total : " + data.grandtotal().toStringAsFixed(0)),
              Text("Total profit : " + data.totalProfit().toStringAsFixed(0)),
            ],
          ),
        ),
      ]),
    );
  }
}
