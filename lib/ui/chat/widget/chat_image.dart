import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/message.dart';

class ChatImage extends StatelessWidget {
  const ChatImage({super.key, required this.message, required this.receiverId});

  final Message message;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: message.senderId == receiverId
          ? Alignment.centerRight
          : Alignment.centerLeft,
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
          CachedNetworkImage(
            imageUrl: message.message,
            width: 200,
            height: 250,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
