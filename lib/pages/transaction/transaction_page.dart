import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/boxes.dart';
import 'package:pos/database/transaction.dart';
import 'package:pos/function/date.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
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
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              Transaction current = transactions[index];
              return ListTile(
                title: Text(toNormalDate(current.date)),
                subtitle: Text("Total Profit : " +
                    current.grandtotal().toStringAsFixed(2)),
              );
            },
          );
        },
      ),
    );
  }
}
