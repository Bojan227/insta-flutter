import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_bookmarks.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_posts.dart';

import '../../../blocs/bookmarks/bookmarks_bloc.dart';
import '../../../theme/custom_theme.dart';

class UserDetailsTabs extends StatelessWidget {
  const UserDetailsTabs({super.key, required this.bookmarksBloc});

  final BookmarksBloc bookmarksBloc;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        TabBar(
          indicatorColor: customTheme.onSecondary,
          labelColor: customTheme.onSecondary,
          labelPadding: const EdgeInsets.only(bottom: 16, top: 12),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Icon(
              Icons.grid_on,
              color: customTheme.onSecondary,
            ),
            Icon(Icons.bookmark, color: customTheme.onSecondary)
          ],
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
