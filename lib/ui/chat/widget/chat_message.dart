import 'package:flutter/material.dart';
import '../../../models/message.dart';
import '../../../theme/custom_theme.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key, required this.message, required this.receiverId});

  final Message message;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

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
            borderRadius: BorderRadius.circular(18),
            color: customTheme.onBackground),
        child: Row(
          children: [
            message.senderId != receiverId
                ? CircleAvatar(
                    child: Text(
                      'w',
                      style: TextStyle(color: customTheme.onSecondary),
                    ),
                  )
                : Container(),
            const SizedBox(
              width: 12,
            ),
            Text(
              message.message,
              textAlign: TextAlign.left,
              style: TextStyle(color: customTheme.onSecondary),
            )
          ],
        ),
      ),
    );
  }
}
