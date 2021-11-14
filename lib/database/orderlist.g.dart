part of 'orderlist.dart';

OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
      capital: json['capital'] as double,
      idproduct: json['idproduct'] as String,
      name: json['name'] as String,
      price: json['price'] as double,
      qty: json['qty'] as int,
    );

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'capital': instance.capital,
      'idproduct': instance.idproduct,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
    };
