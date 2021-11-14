part 'orderlist.g.dart';

class OrderList {
  final String name;
  final String idproduct;
  int qty;
  final double price;
  final double capital;
  OrderList({
    required this.idproduct,
    required this.name,
    required this.price,
    required this.qty,
    required this.capital,
  });
  double subtotal() => price * qty;
  double profit() => subtotal() - capital * qty;
  @override
  String toString() {
    return 'OrderList{name:$name, idproduct:$idproduct, qty:$qty, price:$price}';
  }

  factory OrderList.fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListToJson(this);
}
