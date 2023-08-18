import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pettygram_flutter/ui/chat/widget/chat_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Chat'),
      ),
      body: const ChatList(),
    );
  }
}
