import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/product.dart';

class Boxes {
  static Box<Product> getProduct() => Hive.box<Product>('product');
}

void main() {
  Boxes.getProduct().listenable().value;
}
