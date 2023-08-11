import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/models/comment_body.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';

class AddCommentWidget extends StatelessWidget {
  AddCommentWidget({super.key, required this.post});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String comment = '';
  final String post;

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final commentBody = CommentBody(comment: comment, post: post);

      BlocProvider.of<CommentsBloc>(context)
          .add(AddComment(commentBody: commentBody));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: BlocConsumer<CommentsBloc, CommentsState>(
        listener: (context, state) {
          if (state.newCommentStatus == CommentStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Comment Added"),
              ),
            );

            context.read<CommentsBloc>().add(
                  GetComments(postId: post),
                );
            _formKey.currentState!.reset();
          }

          if (state.newCommentStatus == CommentStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Comment fail to be added'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                        handleInput: (value) => comment = value,
                        obscureText: false,
                        label: 'Add a comment'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  TextButton(
                    onPressed: () {
                      onSubmit(context);
                    },
                    child: Text(state.newCommentStatus == CommentStatus.loading
                        ? "Loading...."
                        : 'Post'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
