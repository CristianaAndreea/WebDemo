import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  final int? id;
  final String email;
  final String name;
  final String password;
  final String token;

  const User({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.token,
  });

  factory User.fromMap(Map map) {
    return User(
      id: map['id'],
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
