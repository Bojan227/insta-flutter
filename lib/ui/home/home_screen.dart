import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/widgets/post_item.dart';
import 'package:pettygram_flutter/widgets/stories.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String? token =
      getIt<SharedPreferencesConfig>().getString('accessToken');

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const StoriesWidget(),
      BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostFailed) {
            return Center(
              child: Text("${state.error}"),
            );
          }

          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('No Posts yet'),
              );
            }

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      state.posts.map((post) => PostItem(post: post)).toList(),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    ]);
  }
}
