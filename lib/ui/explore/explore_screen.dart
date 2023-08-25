import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: state is UserPostsLoaded
                ? state.userPosts
                    .mapWithIndex((t, index) => index == 2 || index == 11
                        ? StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 3,
                            child: CachedNetworkImage(
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: t.imageUrl![0],
                              fit: BoxFit.cover,
                            ),
                          )
                        : StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: CachedNetworkImage(
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: t.imageUrl![0],
                              fit: BoxFit.cover,
                            ),
                          ))
                    .toList()
                : [
                    const Center(
                      child: Text('Explore is empty'),
                    )
                  ],
          ),
        );
      },
    );
  }
}
