import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/ui/comments/widgets/edit_comment.dart';
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          CircleImage(imageUrl: comment.createdBy!['imageUrl']),
          const SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${comment.createdBy!['username']}',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    EditCommentWidget(
                      comment: comment.comment!,
                      commentId: comment.id!,
                    ),
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
                      '${comment.likes?.length} ${comment.likes?.length == 1 ? 'like' : 'likes'}',
                    )
                  ],
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<CommentsBloc>()
                  .add(ToggleCommentLike(commentId: comment.id!));
            },
            icon: Icon(
              comment.isLiked() ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
