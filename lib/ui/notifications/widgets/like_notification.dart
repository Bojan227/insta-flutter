import 'package:flutter/material.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

import '../../../models/notification.dart';

class LikeNotification extends StatelessWidget {
  const LikeNotification({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleImage(
            imageUrl: notification.sender.imageUrl,
            radius: 24,
          ),
          const SizedBox(
            width: 18,
          ),
          Text("${notification.sender.username} liked your post")
        ],
      ),
    );
  }
}
