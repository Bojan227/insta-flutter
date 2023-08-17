import 'package:flutter/material.dart';

import '../../../models/message.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key, required this.message, required this.receiverId});

  final Message message;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: message.senderId == receiverId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: 255,
        height: 80,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: message.senderId == receiverId
                ? Colors.amberAccent
                : Colors.greenAccent),
        child: Column(
          children: [
            Text(
              message.senderUsername,
              textAlign: TextAlign.left,
            ),
            Text(
              message.message,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
