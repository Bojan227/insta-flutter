import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification.dart';

abstract class INotificationsProvider {
  Future<void> sendNotification(
      String receiverId, NotificationModel notification);
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<void> readNotifications(String userId);
}

class NotificationsProvider implements INotificationsProvider {
  const NotificationsProvider({required this.firestore});

  final FirebaseFirestore firestore;
  @override
  Future<void> sendNotification(
      String receiverId, NotificationModel notification) async {
    await firestore
        .collection('notifications')
        .doc(receiverId)
        .collection('notifications_list')
        .add(notification.toMap());
  }

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) async* {
    yield* firestore
        .collection('notifications')
        .doc(userId)
        .collection('notifications_list')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((snapshot) => NotificationModel.fromMap(snapshot.data()))
              .toList(),
        );
  }

  @override
  Future<void> readNotifications(String userId) async {
    final snapshots = await firestore
        .collection("notifications")
        .doc(userId)
        .collection('notifications_list')
        .get();

    for (var doc in snapshots.docs) {
      await doc.reference.update({"isRead": true});
    }
  }
}
