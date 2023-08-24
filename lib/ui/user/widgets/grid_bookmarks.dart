import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/bookmarks/bookmarks_bloc.dart';
import 'package:pettygram_flutter/ui/user/widgets/grid_builder.dart';

import '../../../utils/enums.dart';

class GridBookmarks extends StatelessWidget {
  const GridBookmarks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarksBloc, BookmarksState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == Status.failure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        if (state.status == Status.success) {
          if (state.bookmarkedPosts.isEmpty) {
            return const Center(
              child: Text('Save your first post'),
            );
          }

          return GridBuilder(posts: state.bookmarkedPosts);
        }

        return Container();
      },
    );
  }
}
