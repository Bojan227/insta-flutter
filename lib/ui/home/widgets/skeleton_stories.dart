import 'package:flutter/material.dart';

class SkeletonStories extends StatelessWidget {
  const SkeletonStories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient:
                        LinearGradient(colors: [Colors.purple, Colors.orange]),
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius: 40,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  width: 70,
                  height: 12,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: const Text(
                    '',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ));
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
