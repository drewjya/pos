import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/product.dart';
import 'package:pos/database/transaction.dart';

class Boxes {
  static Box<Product> getProduct() => Hive.box<Product>('product');
  static Box<Transaction> getTransaction() =>
      Hive.box<Transaction>('transaction');
}

void main() {
  Boxes.getProduct().listenable().value;
}
