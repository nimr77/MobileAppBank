import 'package:flutter/cupertino.dart';

class MyCard {
  String id;
  String number;
  String pin;
  int whenCreated;
  int whenExpired;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyCard({
    @required this.id,
    @required this.number,
    @required this.pin,
    @required this.whenCreated,
    @required this.whenExpired,
    @required this.name,
  });

  MyCard copyWith({
    String id,
    String number,
    String pin,
    int whenCreated,
    int whenExpired,
    String name,
  }) {
    return new MyCard(
      id: id ?? this.id,
      number: number ?? this.number,
      pin: pin ?? this.pin,
      whenCreated: whenCreated ?? this.whenCreated,
      whenExpired: whenExpired ?? this.whenExpired,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'MyCard{id: $id, number: $number, pin: $pin, whenCreated: $whenCreated, whenExpired: $whenExpired, name: $name}';
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
          whenExpired == other.whenExpired &&
          name == other.name);

  @override
  int get hashCode =>
      id.hashCode ^
      number.hashCode ^
      pin.hashCode ^
      whenCreated.hashCode ^
      whenExpired.hashCode ^
      name.hashCode;

  factory MyCard.fromMap(Map<String, dynamic> map) {
    return new MyCard(
      id: map['id'] as String,
      number: map['number'] as String,
      pin: map['pin'] as String,
      whenCreated: map['whenCreated'] as int,
      whenExpired: map['whenExpired'] as int,
      name: map['name'] as String,
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
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
