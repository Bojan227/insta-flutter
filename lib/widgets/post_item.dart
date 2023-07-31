import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/user/user_post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/utils/parse_date.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final User user = User.fromJson(post.createdBy!);

    DateTime dateTime = parseDateString(post.createdAt!);
    String formattedDate =
        "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";

    return BlocBuilder<UserPostBloc, UserPostsState>(
      builder: (context, state) {
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        color: Colors.black12,
                        child: GestureDetector(
                          onTap: () {
                            context.push('/profile', extra: user);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: CachedNetworkImage(
                                    imageUrl: user.imageUrl!),
                              ),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                post.isLiked("63fc9f28497159fe4ec5e254")
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                        state is UserPostSaving
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  context.read<UserPostBloc>().add(
                                        ToggleBookmark(postId: post.id!),
                                      );
                                },
                                icon: state is UserPostBookmarked
                                    ? Icon(state.user.isSaved(post.id!)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border)
                                    : Icon(user.isSaved(post.id!)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border),
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${post.likes!.length} ${post.likes!.length == 1 ? "like" : "likes"}",
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.username}",
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                post.text!.substring(
                                  0,
                                  min(post.text!.length, 10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            onPressed: () {},
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
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
