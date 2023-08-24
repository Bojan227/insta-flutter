import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/utils/enums.dart';

import 'firebase_user.dart';

class NotificationModel extends Equatable {
  final String receiverId;
  final FirebaseUser sender;
  final bool isRead;
  final Timestamp timestamp;
  final NotificationType type;

  const NotificationModel(
      {required this.receiverId,
      required this.isRead,
      required this.timestamp,
      required this.type,
      required this.sender});

  @override
  List<Object?> get props => [receiverId, isRead, timestamp, type, sender];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiverId': receiverId,
      'sender': jsonEncode(sender.toJson()),
      'isRead': isRead,
      'timestamp': timestamp,
      'type': fromEnum(type),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
        receiverId: map['receiverId'] as String,
        sender: FirebaseUser.fromJson(jsonDecode(map['sender'])),
        isRead: map['isRead'] as bool,
        timestamp: map['timestamp'],
        type: toEnum(map['type']));
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static String fromEnum(NotificationType type) {
    switch (type) {
      case NotificationType.comment:
        return 'comment';
      case NotificationType.like:
        return 'like';
      default:
        return 'follow';
    }
  }

  static NotificationType toEnum(String value) {
    switch (value) {
      case 'comment':
        return NotificationType.comment;
      case 'like':
        return NotificationType.like;
      default:
        return NotificationType.follow;
    }
  }
}
