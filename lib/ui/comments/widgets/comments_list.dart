import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/models/comment.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comment_item.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CommentsLoaded) {
          return state.comments.isEmpty
              ? const Center(
                  child: Text('Add the first comment!'),
                )
              : Column(
                  children: state.comments
                      .map(
                        (comment) => CommentItem(comment: comment),
                      )
                      .toList(),
                );
        }

        if (state is CommentsFailed) {
          return Center(
            child: Text(state.error),
          );
        }

        return Container();
      },
    );
  }
}
