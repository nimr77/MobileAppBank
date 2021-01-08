import 'package:flutter/cupertino.dart';

class MyAmount {
  String id;
  String cardID;
  double total;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyAmount({
    @required this.id,
    @required this.cardID,
    @required this.total,
  });

  MyAmount copyWith({
    String id,
    String cardID,
    double total,
  }) {
    return new MyAmount(
      id: id ?? this.id,
      cardID: cardID ?? this.cardID,
      total: total ?? this.total,
    );
  }

  @override
  String toString() {
    return 'MyAmount{id: $id, cardID: $cardID, total: $total}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyAmount &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardID == other.cardID &&
          total == other.total);

  @override
  int get hashCode => id.hashCode ^ cardID.hashCode ^ total.hashCode;

  factory MyAmount.fromMap(Map<String, dynamic> map) {
    return new MyAmount(
      id: map['id'] as String,
      cardID: map['cardID'] as String,
      total: map['total'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'cardID': this.cardID,
      'total': this.total,
    } as Map<String, dynamic>;
  }

//</editor-fold>
  static MyAmount me;
}
