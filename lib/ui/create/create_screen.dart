import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/widgets/image_input.dart';
import 'package:pettygram_flutter/widgets/textarea.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String caption = '';
  List<String> images = [];

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate() && images.isNotEmpty) {
      _formKey.currentState!.save();

      BlocProvider.of<PostBloc>(context).add(
        AddPost(
          userPost: PostBody(text: caption, images: images),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.addPostStatus == AddPostStatus.success ||
            state.addPostStatus == AddPostStatus.failure) {
          // BlocProvider.of<PostBloc>(context).add(GetPosts());
          context.go('/');
        }
      },
      child: Dismissible(
        key: const ValueKey("dismiss_key"),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => context.go('/'),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    _onSubmit(context);
                  },
                  child: Text(
                    "POST",
                    style: const TextStyle().copyWith(fontSize: 20),
                  ))
            ],
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.go('/'),
            ),
            title: const Text('Add Post'),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ImageInput(handleImageInput: (image) => images = image),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: _formKey,
                  child: TextArea(
                    handleInput: (value) => caption = value,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
