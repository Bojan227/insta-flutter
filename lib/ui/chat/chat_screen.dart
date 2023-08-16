import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/chat/bloc/chat_bloc.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_page.dart';

import '../../injector/injector.dart';
import '../../storage/shared_preferences.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final SharedPreferencesConfig storageConfig =
      getIt<SharedPreferencesConfig>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }

          print(snapshot?.data!.docs);
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildUserListItem(doc, context))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final Token token =
        Token(accessToken: storageConfig.getString('accessToken') ?? '');

    if (token.accessToken != data['token']) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ChatBloc(storage: storageConfig),
                child: ChatPage(username: data['username'], userId: data['id']),
              ),
            ),
          );
        },
        title: Text(data['username'] ?? "-"),
      );
    } else {
      return Container();
    }
  }
}
