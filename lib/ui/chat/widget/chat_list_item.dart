import 'package:flutter/material.dart';
import 'package:pettygram_flutter/models/firebase_user.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.user});

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleImage(
            imageUrl: user.imageUrl,
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
              child: Text(
            user.username,
            style: const TextStyle(fontSize: 24),
          ))
        ],
      ),
    );
  }
}
