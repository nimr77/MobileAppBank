import 'package:flutter/cupertino.dart';

class MyHistory {
  String id;
  int when;
  double amount;

  static List<MyHistory> listOfMe = List<MyHistory>();
}

class MyWithdrawHistory implements MyHistory {
  @override
  double amount;

  @override
  String id;

  @override
  int when;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyWithdrawHistory({
    @required this.amount,
    @required this.id,
    @required this.when,
  });

  MyWithdrawHistory copyWith({
    double amount,
    String id,
    int when,
  }) {
    return new MyWithdrawHistory(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      when: when ?? this.when,
    );
  }

  @override
  String toString() {
    return 'MyWithdrawHistory{amount: $amount, id: $id, when: $when}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyWithdrawHistory &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          when == other.when);

  @override
  int get hashCode => amount.hashCode ^ id.hashCode ^ when.hashCode;

  factory MyWithdrawHistory.fromMap(Map<String, dynamic> map) {
    return new MyWithdrawHistory(
      amount: map['amount'] as double,
      id: map['id'] as String,
      when: map['when'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'id': this.id,
      'when': this.when,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class MyDepositHistory implements MyHistory {
  @override
  double amount;

  @override
  String id;

  @override
  int when;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyDepositHistory({
    @required this.amount,
    @required this.id,
    @required this.when,
  });

  MyDepositHistory copyWith({
    double amount,
    String id,
    int when,
  }) {
    return new MyDepositHistory(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      when: when ?? this.when,
    );
  }

  @override
  String toString() {
    return 'MyDepositHistory{amount: $amount, id: $id, when: $when}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyDepositHistory &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          when == other.when);

  @override
  int get hashCode => amount.hashCode ^ id.hashCode ^ when.hashCode;

  factory MyDepositHistory.fromMap(Map<String, dynamic> map) {
    return new MyDepositHistory(
      amount: map['amount'] as double,
      id: map['id'] as String,
      when: map['when'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'id': this.id,
      'when': this.when,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
