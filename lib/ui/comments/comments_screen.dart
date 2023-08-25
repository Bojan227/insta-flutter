import 'package:flutter/material.dart';
import 'package:pettygram_flutter/ui/comments/widgets/add_comment.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comments_list.dart';

import '../../theme/custom_theme.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: customTheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: customTheme.onSecondary),
        backgroundColor: customTheme.primary,
        title: Text(
          'Comments',
          style: TextStyle(color: customTheme.onSecondary),
        ),
      ),
      body: Container(
        color: customTheme.primary,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Text(
                        'Header',
                        style: TextStyle(color: customTheme.onSecondary),
                      ),
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
