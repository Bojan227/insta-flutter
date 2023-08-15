import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/user/cubit/user_cubit.dart';
import 'package:pettygram_flutter/ui/user/widgets/edit_profile.dart';
import 'package:pettygram_flutter/ui/user/widgets/user_details_tabs.dart';
import 'package:pettygram_flutter/ui/user/widgets/user_info.dart';

import '../../blocs/bookmarks/bookmarks_bloc.dart';
import '../../blocs/posts/post_bloc.dart';
import '../../blocs/users/users_bloc.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.bookmarksBloc});
  final BookmarksBloc bookmarksBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            context.read<PostBloc>().add(const GetPosts(page: 0));
            context.read<UsersBloc>().add(GetUsers());
            context.pop();
          },
        ),
        title: BlocBuilder<UserCubit, UserStateCubit>(
          builder: (context, state) {
            return Text(state is UserLoaded ? state.user.username! : 'Loading');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {},
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const UserInfo(),
                    const SizedBox(
                      height: 12,
                    ),
                    const EditProfile()
                  ],
                ),
              ),
            ];
          },
          body: UserDetailsTabs(bookmarksBloc: bookmarksBloc),
        ),
      ),
    );
  }
}
