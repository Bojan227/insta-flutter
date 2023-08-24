// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    required this.notifications,
    required this.status,
  });

  final Status status;
  final List<NotificationModel> notifications;

  @override
  List<Object> get props => [status, notifications];

  NotificationsState copyWith({
    Status? status,
    List<NotificationModel>? notifications,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }

  int numberOfUnreadNotifications() {
    return notifications.where((notification) => !notification.isRead).length;
  }
}
