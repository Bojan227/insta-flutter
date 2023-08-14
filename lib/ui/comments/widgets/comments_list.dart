import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comment_item.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state.status == CommentStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == CommentStatus.success) {
          return state.comments.isEmpty
              ? const Center(
                  child: Text('Add comment!'),
                )
              : Column(
                  children: state.comments
                      .map(
                        (comment) => Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(color: Colors.red),
                          key: Key(comment.id!),
                          onDismissed: (direction) {
                            context
                                .read<CommentsBloc>()
                                .add(DeleteComment(commentId: comment.id!));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Comment deleted'),
                              ),
                            );
                          },
                          child: CommentItem(
                            key: Key(comment.id!),
                            comment: comment,
                          ),
                        ),
                      )
                      .toList(),
                );
        }

        if (state.status == CommentStatus.failure) {
          return const Center(
            child: Text('Failed to fetch'),
          );
        }

        return Container();
      },
    );
  }
}
