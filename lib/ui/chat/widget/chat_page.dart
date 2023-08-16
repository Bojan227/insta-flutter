import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/chat/bloc/chat_bloc.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';

import '../../../models/message.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.username, required this.userId});

  final String username;
  final String userId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String newMessage = '';

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<ChatBloc>(context).add(
        SendMessage(receiverId: userId, newMessage: newMessage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> ids = ['63f76bdcb090e8f5b7015c41', '63f76286810a293888d18152'];
    ids.sort();
    String chatRoomId = ids.join("_");

    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat_rooms')
                  .doc(chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                List<Message> messages =
                    snapshot.data!.docs.map((DocumentSnapshot doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return Message(
                      senderId: data['senderId'],
                      senderUsername: data['senderUsername'],
                      receiverId: data['receiverId'],
                      message: data['message'],
                      timestamp: data['timestamp']);
                }).toList();

                return SingleChildScrollView(
                  child: Column(
                    children: messages
                        .map((message) => Container(
                              padding: const EdgeInsets.all(12),
                              alignment: message.senderId == userId
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 255,
                                height: 80,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: message.senderId == userId
                                        ? Colors.amberAccent
                                        : Colors.greenAccent),
                                child: Column(
                                  children: [
                                    Text(
                                      message.senderUsername,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      message.message,
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                  child: InputField(
                      handleInput: (value) => newMessage = value,
                      obscureText: false,
                      label: 'Message'),
                ),
              ),
              IconButton(
                onPressed: () {
                  onSubmit(context);
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ],
      ),
    );
  }
}
