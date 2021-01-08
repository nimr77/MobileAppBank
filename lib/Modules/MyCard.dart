import 'package:flutter/cupertino.dart';

class MyCard {
  String id;
  String number;
  String pin;
  int whenCreated;
  int whenExpired;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyCard({
    @required this.id,
    @required this.number,
    @required this.pin,
    @required this.whenCreated,
    @required this.whenExpired,
  });

  MyCard copyWith({
    String id,
    String number,
    String pin,
    int whenCreated,
    int whenExpired,
  }) {
    return new MyCard(
      id: id ?? this.id,
      number: number ?? this.number,
      pin: pin ?? this.pin,
      whenCreated: whenCreated ?? this.whenCreated,
      whenExpired: whenExpired ?? this.whenExpired,
    );
  }

  @override
  String toString() {
    return 'MyCard{id: $id, number: $number, pin: $pin, whenCreated: $whenCreated, whenExpired: $whenExpired}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyCard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          number == other.number &&
          pin == other.pin &&
          whenCreated == other.whenCreated &&
          whenExpired == other.whenExpired);

  @override
  int get hashCode =>
      id.hashCode ^
      number.hashCode ^
      pin.hashCode ^
      whenCreated.hashCode ^
      whenExpired.hashCode;

  factory MyCard.fromMap(Map<String, dynamic> map) {
    return new MyCard(
      id: map['id'] as String,
      number: map['number'] as String,
      pin: map['pin'] as String,
      whenCreated: map['whenCreated'] as int,
      whenExpired: map['whenExpired'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'number': this.number,
      'pin': this.pin,
      'whenCreated': this.whenCreated,
      'whenExpired': this.whenExpired,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}
