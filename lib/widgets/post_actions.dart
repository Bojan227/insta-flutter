import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';

class PostActions extends StatelessWidget {
  const PostActions({super.key, required this.post, required this.user});

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostBloc, UserPostsState>(
      builder: (context, state) {
        return Row(
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
        );
      },
    );
  }
}
