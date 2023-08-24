import 'package:pettygram_flutter/api/notifications_provider.dart';
import 'package:pettygram_flutter/api/notifications_repository.dart';
import 'package:pettygram_flutter/models/notification.dart';

class NotificationsRepository implements INotificationRepository {
  const NotificationsRepository({required this.provider});

  final NotificationsProvider provider;

  @override
  Future<void> sendNotifiction(
      String receiverId, NotificationModel notification) async {
    return await provider.sendNotification(receiverId, notification);
  }

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) async* {
    yield* provider.getNotifications(userId);
  }

  @override
  Future<void> readNotifications(String userId) async {
    return await provider.readNotifications(userId);
  }
}
