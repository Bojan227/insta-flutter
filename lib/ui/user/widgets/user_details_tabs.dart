import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_bookmarks.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_posts.dart';

import '../../../blocs/bookmarks/bookmarks_bloc.dart';

class UserDetailsTabs extends StatelessWidget {
  const UserDetailsTabs({super.key, required this.bookmarksBloc});

  final BookmarksBloc bookmarksBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: Theme.of(context).colorScheme.onSecondary,
          labelColor: Theme.of(context).colorScheme.onSecondary,
          labelPadding: const EdgeInsets.only(bottom: 16, top: 12),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [Icon(Icons.grid_on), Icon(Icons.bookmark)],
        ),
        Expanded(
          child: TabBarView(
            children: [
              const GridPosts(),
              BlocProvider.value(
                value: bookmarksBloc..add(GetBookmarks()),
                child: const GridBookmarks(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
