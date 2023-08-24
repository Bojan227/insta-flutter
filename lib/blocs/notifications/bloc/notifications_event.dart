part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SendNotification extends NotificationsEvent {
  const SendNotification({required this.receiverId, required this.type});

  final String receiverId;
  final NotificationType type;

  @override
  List<Object> get props => [receiverId, type];
}

class GetNotifications extends NotificationsEvent {
  const GetNotifications();
}

class ReadNotifications extends NotificationsEvent {
  const ReadNotifications();
}
