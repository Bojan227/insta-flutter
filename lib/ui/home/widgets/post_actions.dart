import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';

class PostActions extends StatelessWidget {
  const PostActions({super.key, required this.post, required this.user});

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<PostBloc>().add(
                          ToggleLike(postId: post.id!),
                        );
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 3000),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                        child: child,
                      );
                    },
                    child: Icon(
                      key: ValueKey(post.isLiked("63f76286810a293888d18152")),
                      post.isLiked("63f76286810a293888d18152")
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
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
                ? CircularProgressIndicator(
                    backgroundColor: Colors.blue[100]!,
                  )
                : IconButton(
                    onPressed: () {
                      context.read<UserBloc>().add(
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
