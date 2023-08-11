import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1),
      itemBuilder: (context, index) => CachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        imageUrl: posts[index].imageUrl![0],
      ),
    );
    ;
  }
}
