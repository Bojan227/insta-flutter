import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';
import '../../../models/user.dart';
import '../../../theme/custom_theme.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    final customeTheme = Theme.of(context).extension<CustomTheme>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: users
            .map(
              (user) => GestureDetector(
                onTap: () => context.push('/profile', extra: user.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleImage(imageUrl: user.imageUrl!),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        user.username!,
                        textAlign: TextAlign.center,
                        style: const TextStyle()
                            .copyWith(color: customeTheme?.onSecondary),
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
