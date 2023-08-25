import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettygram_flutter/blocs/chat/bloc/chat_bloc.dart';
import 'package:pettygram_flutter/models/message.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_image.dart';
import 'package:pettygram_flutter/ui/chat/widget/chat_message.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';
import 'dart:convert';
import 'dart:io';

import '../../../theme/custom_theme.dart';

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
        SendMessage(
            receiverId: receiverId, newMessage: newMessage, type: 'message'),
      );
    }
  }

  void takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    File imagefile = File(pickedImage.path);

    if (context.mounted) {
      BlocProvider.of<ChatBloc>(context)
          .add(UploadImage(image: imagefile, receiverId: receiverId));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: customTheme.background,
      appBar: AppBar(
        backgroundColor: customTheme.onBackground,
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
                        (message) => message.type == 'media'
                            ? ChatImage(
                                message: message, receiverId: receiverId)
                            : ChatMessage(
                                message: message, receiverId: receiverId),
                      )
                      .toList(),
                ),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                IconButton(
                  color: customTheme.onSecondary,
                  onPressed: () {
                    takePicture(context);
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
                const SizedBox(
                  width: 4,
                ),
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
                  color: customTheme.onSecondary,
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
          ),
        ],
      ),
    );
  }
}
