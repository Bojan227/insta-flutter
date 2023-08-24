import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/notifictaions_repo_impl.dart';
import 'package:pettygram_flutter/models/firebase_user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

import '../../../models/notification.dart';
import '../../../models/user.dart';
import '../../../utils/enums.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository notificationsRepository;
  final SharedPreferencesConfig storage;

  NotificationsBloc({
    required this.notificationsRepository,
    required this.storage,
  }) : super(
          const NotificationsState(
            notifications: [],
            status: Status.initial,
          ),
        ) {
    on<SendNotification>(_onSendNotification);
    on<GetNotifications>(_onGetNotifications);
    on<ReadNotifications>(_onReadNotifications);
  }

  Future<void> _onSendNotification(SendNotification event, Emitter emit) async {
    final Timestamp timestamp = Timestamp.now();
    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    final FirebaseUser sender = FirebaseUser(
        id: currentUser['id'],
        username: currentUser['username'],
        imageUrl: currentUser['imageUrl']);

    try {
      if (currentUser['id'] == null) return;

      final NotificationModel notification = NotificationModel(
          receiverId: event.receiverId,
          sender: sender,
          isRead: false,
          timestamp: timestamp,
          type: event.type);

      await notificationsRepository.sendNotifiction(
          event.receiverId, notification);

      emit(state.copyWith(status: Status.success));
    } catch (error) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onGetNotifications(GetNotifications event, Emitter emit) async {
    bool isKeyPresent = storage.isKeyPresent('accessUser');

    if (!isKeyPresent) return;

    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    await emit.forEach(
      notificationsRepository.getNotifications(currentUser['id']),
      onData: (List<NotificationModel> data) => NotificationsState(
        notifications: data,
        status: Status.success,
      ),
    );
  }

  Future<void> _onReadNotifications(
      ReadNotifications event, Emitter emit) async {
    bool isKeyPresent = storage.isKeyPresent('accessUser');

    if (!isKeyPresent) return;

    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    await notificationsRepository.readNotifications(currentUser['id']);
  }
}
