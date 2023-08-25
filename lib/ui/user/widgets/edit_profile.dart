import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/user/cubit/user_cubit.dart';

import '../../../theme/custom_theme.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>();

    return BlocBuilder<UserCubit, UserStateCubit>(
      builder: (ctx, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (state is UserLoaded) {
                      ctx.push('/profile/edit', extra: state.user);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: customTheme?.onBackground,
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(10, 10),
                      ),
                    ),
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: const TextStyle()
                          .copyWith(color: customTheme?.onSecondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              const Icon(Icons.explore_rounded)
            ],
          ),
        );
      },
    );
  }
}
