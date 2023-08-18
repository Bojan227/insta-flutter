// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String message;
  final String type;
  final Timestamp timestamp;
  Message(
      {required this.senderId,
      required this.senderUsername,
      required this.receiverId,
      required this.message,
      required this.timestamp,
      required this.type});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      senderUsername: map['senderUsername'],
      message: map['message'],
      receiverId: map['receiverId'],
      timestamp: map['timestamp'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'type': type
    };
  }
}
