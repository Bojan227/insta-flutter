import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/user_posts/user_post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';

class GridPosts extends StatelessWidget {
  const GridPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostBloc, UserPostsState>(
      builder: (context, state) {
        if (state is UserPostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserPostsFailed) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is UserPostsLoaded) {
          if (state.userPosts.isEmpty) {
            return const Center(
              child: Text('Add your first post'),
            );
          }

          return GridView.builder(
            itemCount: state.userPosts.length,
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
              imageUrl: state.userPosts[index].imageUrl![0],
            ),
          );
        }

        return Container();
      },
    );
  }
}
