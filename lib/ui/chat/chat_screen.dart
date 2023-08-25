import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pettygram_flutter/ui/chat/widget/chat_list.dart';

import '../../theme/custom_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: customTheme.background,
      appBar: AppBar(
        backgroundColor: customTheme.onBackground,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
          color: customTheme.onSecondary,
        ),
        title: Text(
          'Chat',
          style: TextStyle(color: customTheme.onSecondary),
        ),
      ),
      body: const ChatList(),
    );
  }
}
