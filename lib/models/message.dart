import 'package:flutter/material.dart';

import 'package:gesplai/screens/widgets/utils.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String idWriter;
  final String username;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.idWriter,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        idWriter: json['idWriter'],
        username: json['username'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idWriter': idWriter,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
