import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';
import 'package:pettygram_flutter/ui/home/widgets/post_actions.dart';
import 'package:pettygram_flutter/ui/home/widgets/post_card_info.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final User user = User.fromJson(post.createdBy!);

    return InkWell(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: post.imageUrl![0],
                width: double.infinity,
                height: 450,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    color: Colors.black12,
                    child: GestureDetector(
                      onTap: () {
                        context.push('/profile', extra: user.id);
                      },
                      child: Row(
                        children: [
                          CircleImage(imageUrl: user.imageUrl!),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "${user.username}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostActions(post: post, user: user),
                const SizedBox(
                  height: 12,
                ),
                PostCardInfo(post: post, user: user)
              ],
            ),
          )
        ],
      ),
    );
  }
}
