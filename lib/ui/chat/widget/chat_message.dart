import 'package:cached_network_image/cached_network_image.dart';
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
        height: 70,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.grey[100]),
        child: Row(
          children: [
            message.senderId != receiverId
                ? const CircleAvatar(
                    child: Text('w'),
                  )
                : Container(),
            const SizedBox(
              width: 12,
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
