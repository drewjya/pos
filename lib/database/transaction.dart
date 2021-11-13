class Transaction {
  final String idtrans;
  final DateTime date;
  final List<OrderList> orderList;
  final List<double> subtotal;
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
