import 'package:flutter/cupertino.dart';

class MyUser {
  String id;
  String email;
  String name;
  static String myCurrentName;
  static String myCurrentId;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MyUser({
    @required this.id,
    @required this.email,
    @required this.name,
  });

  MyUser copyWith({
    String id,
    String email,
    String name,
  }) {
    return new MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'MyUser{id: $id, email: $email, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return new MyUser(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
