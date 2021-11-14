// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 1;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      idtrans: fields[0] as String,
      subtotal: (fields[3] as List).cast<double>(),
      orderList: (fields[2] as List).cast<OrderList>(),
      date: fields[1] as DateTime,
      profit: (fields[4] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idtrans)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.orderList)
      ..writeByte(3)
      ..write(obj.subtotal)
      ..writeByte(4)
      ..write(obj.profit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
