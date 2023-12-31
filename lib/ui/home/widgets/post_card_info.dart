import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/utils/parse_date.dart';

import '../../../theme/custom_theme.dart';

class PostCardInfo extends StatelessWidget {
  const PostCardInfo({super.key, required this.post, required this.user});

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    DateTime dateTime = parseDateString(post.createdAt!);
    String formattedDate =
        "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "${post.likes!.length} ${post.likes!.length == 1 ? "like" : "likes"}",
              textAlign: TextAlign.start,
              style: TextStyle(color: customTheme.onSecondary)),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.username}",
                style: TextStyle(color: customTheme.onSecondary),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                post.text!.substring(
                  0,
                  min(post.text!.length, 10),
                ),
                style: TextStyle(
                  color: customTheme.onSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          TextButton(
            onPressed: () {
              context.push('/comments', extra: post.id);
            },
            child: const Text(
              'View all comments',
              style: TextStyle(
                color: Color.fromARGB(255, 167, 161, 161),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            formattedDate,
            style: const TextStyle(
              color: Color.fromARGB(255, 167, 161, 161),
            ),
          )
        ],
      ),
    );
  }
}
