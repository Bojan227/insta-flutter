import 'package:flutter/material.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comments_list.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: const Text('Header'),
          ),
          const CommentsList()
        ],
      )),
    );
  }
}
