import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/theme/custom_theme.dart';
import 'package:pettygram_flutter/widgets/image_input.dart';
import 'package:pettygram_flutter/widgets/textarea.dart';

import '../../utils/enums.dart';

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
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.addPostStatus == Status.success ||
            state.addPostStatus == Status.failure) {
          context.go('/');
        }
      },
      child: Dismissible(
        key: const ValueKey("dismiss_key"),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => context.go('/'),
        child: Scaffold(
          backgroundColor: customTheme.background,
          appBar: AppBar(
            backgroundColor: customTheme.primary,
            iconTheme: IconThemeData(color: customTheme.onSecondary),
            actions: [
              TextButton(
                  onPressed: () {
                    _onSubmit(context);
                  },
                  child: Text(
                    "POST",
                    style: const TextStyle()
                        .copyWith(fontSize: 20, color: customTheme.onSecondary),
                  ))
            ],
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.go('/'),
            ),
            title: Text(
              'Add Post',
              style: TextStyle(color: customTheme.onSecondary),
            ),
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
