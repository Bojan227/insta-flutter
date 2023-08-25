import 'package:flutter/material.dart';
import 'package:pettygram_flutter/models/firebase_user.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../../../theme/custom_theme.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.user});

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      width: double.infinity,
      decoration: BoxDecoration(
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: TextStyle(fontSize: 24, color: customTheme.onSecondary),
              ),
              Text(
                'Active now',
                style: TextStyle(fontSize: 14, color: customTheme.onSecondary),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
