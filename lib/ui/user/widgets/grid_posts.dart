import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_builder.dart';

class GridPosts extends StatelessWidget {
  const GridPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
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

          return GridBuilder(posts: state.userPosts);
        }

        return Container();
      },
    );
  }
}
