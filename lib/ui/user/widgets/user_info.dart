import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user/cubit/user_cubit.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/info_box.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStateCubit>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  state is UserLoaded
                      ? CircleImage(imageUrl: state.user.imageUrl!)
                      : const CircleAvatar(backgroundColor: Colors.grey),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(state is UserLoaded
                      ? "${state.user.firstName} ${state.user.lastName}"
                      : "... ...")
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: Row(
                  children: [
                    const InfoBox(label: 'Posts', info: 0),
                    const SizedBox(
                      width: 25,
                    ),
                    InfoBox(
                        label: 'Followers',
                        info: state is UserLoaded
                            ? state.user.followers!.length
                            : 0),
                    const SizedBox(
                      width: 25,
                    ),
                    InfoBox(
                        label: 'Following',
                        info: state is UserLoaded
                            ? state.user.following!.length
                            : 0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
