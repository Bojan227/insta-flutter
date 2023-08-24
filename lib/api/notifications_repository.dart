import '../models/notification.dart';

abstract class INotificationRepository {
  Future<void> sendNotifiction(
      String receiverId, NotificationModel notification);
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<void> readNotifications(String userId);
}
