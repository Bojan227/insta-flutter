import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pettygram_flutter/ui/user/user_details.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../models/user.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: users
            .map(
              (user) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetails(user: user),
                )),
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
                              colors: [Colors.purple, Colors.orange]),
                        ),
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: CircleImage(imageUrl: user.imageUrl!)),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        user.username!,
                        textAlign: TextAlign.center,
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
