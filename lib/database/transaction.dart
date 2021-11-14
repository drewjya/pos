import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String idtrans;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final List<OrderList> orderList;
  @HiveField(3)
  final List<double> subtotal;
  @HiveField(4)
  final List<double> profit;
  Transaction({
    required this.idtrans,
    required this.subtotal,
    required this.orderList,
    required this.date,
    required this.profit,
  });
  double grandtotal() => subtotal.fold(0, (prev, curr) => prev + curr);
  double totalProfit() => profit.fold(0, (prev, curr) => prev + curr);
}

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
}
