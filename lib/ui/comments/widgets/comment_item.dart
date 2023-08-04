import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../../../models/comment.dart';
import '../../../utils/parse_date.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final Comment comment;

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
                    Text('${comment.likes?.length} likes')
                  ],
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
    );
  }
}
