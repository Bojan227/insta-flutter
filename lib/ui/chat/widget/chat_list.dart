import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_list_item.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_page.dart';

import '../../../blocs/chat/bloc/chat_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(12),
          children: state.users
              .map(
                (user) => InkWell(
                  onTap: () {
                    context.go('/chat/messages', extra: {
                      'receiverId': user.id,
                      "username": user.username
                    });
                  },
                  child: ChatListItem(user: user),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
