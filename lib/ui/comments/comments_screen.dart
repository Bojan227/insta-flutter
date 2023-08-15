import 'package:flutter/material.dart';
import 'package:pettygram_flutter/ui/comments/widgets/add_comment.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comments_list.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: const Text('Header'),
                    ),
                    const CommentsList()
                  ],
                ),
              ),
            ),
            AddCommentWidget(post: postId)
          ],
        ),
      ),
    );
  }
}
