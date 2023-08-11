import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/cubit/cubit/comment_cubit.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../../../models/comment.dart';
import '../../../utils/parse_date.dart';

class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.comment, this.onTap});

  final Comment comment;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = parseDateString(comment.createdAt!);
    String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state.commentStatus == CommentStatus.success) {
          context.read<CommentsBloc>().add(GetComments(postId: comment.post!));
          if (comment.isLiked()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Like Removed'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Like Added'),
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            CircleImage(imageUrl: comment.createdBy!['imageUrl']),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('${comment.createdBy!['username']}'),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(child: Text('${comment.comment}'))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Text(formattedDate),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                          '${comment.likes?.length} ${comment.likes?.length == 1 ? 'like' : 'likes'}')
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                onTap!();
              },
              icon: Icon(
                comment.isLiked() ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
