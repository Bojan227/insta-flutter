import 'package:flutter/material.dart';
import 'package:pettygram_flutter/ui/user/user_details.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../models/user.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserDetails(user: users[index]),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.orange]),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircleImage(imageUrl: users[index].imageUrl!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  users[index].username!,
                  textAlign: TextAlign.center,
                )
              ],
            ));
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
