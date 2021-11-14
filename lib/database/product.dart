import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String idproduct;
  @HiveField(1)
  final String name;
  @HiveField(2)
  double harga;
  @HiveField(3)
  int stock;
  @HiveField(4)
  double hargaModal;
  Product({
    required this.idproduct,
    required this.name,
    required this.harga,
    required this.hargaModal,
    required this.stock,
  });
}
