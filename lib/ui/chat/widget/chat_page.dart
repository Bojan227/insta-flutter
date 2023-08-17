import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/chat/bloc/chat_bloc.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_message.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.username, required this.receiverId});

  final String username;
  final String receiverId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String newMessage = '';

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<ChatBloc>(context).add(
        SendMessage(receiverId: receiverId, newMessage: newMessage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Column(
        children: [
          Expanded(child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return SingleChildScrollView(
                reverse: true,
                controller: scrollController,
                child: Column(
                  children: state.messages
                      .map(
                        (message) => ChatMessage(
                            message: message, receiverId: receiverId),
                      )
                      .toList(),
                ),
              );
            },
          )),
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
                  scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 1000),
                  );
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
