import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/boxes.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/function/date.dart';
import 'package:pos/pages/transaction/detail_tansaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  double doTotalTransaction(List<Transaction> transaction) {
    double total = 0;
    for (var item in transaction) {
      total += item.grandtotal();
    }
    return total;
  }

  Future deleteAll() async {
    final box = Boxes.getTransaction();
    await box.clear();
  }

  double doProfitTransaction(List<Transaction> transaction) {
    double total = 0;
    for (var item in transaction) {
      total += item.totalProfit();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        actions: [
          IconButton(
              onPressed: () {
                deleteAll();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransaction().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Transaction>();
          if (transactions.isEmpty) {
            return const Center(
              child: Text('There\'s no Transaction'),
            );
          }
          return ListView(children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Transaction : " +
                          doTotalTransaction(transactions).toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "All Profit :" +
                          doProfitTransaction(transactions).toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction current = transactions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTransaction(
                                data: current,
                              )),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                current.idtrans,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                toNormalDate(current.date),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                "Total Transaction: " +
                                    current.grandtotal().toStringAsFixed(0),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                "Profit: " +
                                    current.totalProfit().toStringAsFixed(0),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]);
        },
      ),
    );
  }
}
