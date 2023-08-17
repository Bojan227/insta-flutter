import 'package:flutter/material.dart';

import 'package:pettygram_flutter/ui/chat/widget/chat_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const ChatList(),
    );
  }
}
