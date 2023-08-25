import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';

import '../../../theme/custom_theme.dart';
import '../../../widgets/input_field.dart';

class EditCommentWidget extends StatefulWidget {
  const EditCommentWidget(
      {super.key, required this.comment, required this.commentId});

  final String comment;
  final String commentId;

  @override
  State<EditCommentWidget> createState() => _EditCommentWidgetState();
}

class _EditCommentWidgetState extends State<EditCommentWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool shouldEdit = false;

  String newComment = '';

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<CommentsBloc>().add(
            EditComment(commentId: widget.commentId, comment: newComment),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      children: [
        shouldEdit
            ? Expanded(
                child: Form(
                  key: _formKey,
                  child: InputField(
                      defaultValue: widget.comment,
                      handleInput: (value) => newComment = value,
                      obscureText: false,
                      label: ''),
                ),
              )
            : Text(
                widget.comment,
                style: TextStyle(color: customTheme.onSecondary),
              ),
        const SizedBox(
          width: 18,
        ),
        IconButton(
          onPressed: () {
            if (shouldEdit) {
              onSubmit(context);
            }

            setState(() {
              shouldEdit = !shouldEdit;
            });
          },
          icon: Icon(
            shouldEdit ? Icons.check : Icons.edit,
            color: customTheme.onSecondary,
          ),
        )
      ],
    );
  }
}
