import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          )),
    );
  }
}
