import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/users/users_bloc.dart';
import 'package:pettygram_flutter/ui/home/widgets/skeleton_stories.dart';
import 'package:pettygram_flutter/ui/home/widgets/stories_list.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          height: 180,
          child: state is UsersLoaded
              ? StoriesList(users: state.users)
              : state is UsersLoading
                  ? const SkeletonStories()
                  : const Text('No users'),
        );
      },
    );
  }
}
