import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/chat_repo_impl.dart';

import '../../../models/firebase_user.dart';
import '../../../models/message.dart';
import '../../../storage/shared_preferences.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SharedPreferencesConfig storage;
  final ChatRepository chatRepository;

  ChatBloc({required this.storage, required this.chatRepository})
      : super(
          const ChatState(
              messages: [], sendMessageStatus: SendStatus.initial, users: []),
        ) {
    on<SendMessage>(_onSendMessage);
    on<GetMessages>(_onGetMessages);
    on<GetOnlineUsers>(_onGetUsers);
    on<UploadImage>(_onUploadImage);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter emit) async {
    final Timestamp timestamp = Timestamp.now();
    emit(state.copyWith(sendMessageStatus: SendStatus.loading));

    try {
      final Map<String, dynamic> currentUser =
          jsonDecode(storage.getString('accessUser')!);

      final Message message = Message(
          senderId: currentUser['id'],
          senderUsername: currentUser['username'],
          receiverId: event.receiverId,
          message: event.newMessage,
          timestamp: timestamp,
          type: event.type);

      List<String> ids = [currentUser['id'], event.receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      await chatRepository.sendMessage(chatRoomId, message);

      emit(state.copyWith(sendMessageStatus: SendStatus.success));
    } catch (error) {
      print(error);
      emit(state.copyWith(sendMessageStatus: SendStatus.failure));
    }
  }

  Future<void> _onGetMessages(GetMessages event, Emitter emit) async {
    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    List<String> ids = [currentUser['id'], event.receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await emit.forEach(
      chatRepository.getMessages(chatRoomId),
      onData: (List<Message> messages) => ChatState(
          messages: messages,
          sendMessageStatus: SendStatus.initial,
          users: state.users),
    );
  }

  Future<void> _onGetUsers(GetOnlineUsers event, Emitter emit) async {
    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    await emit.forEach(
      chatRepository.getUsers(),
      onData: (List<FirebaseUser> users) => ChatState(
          messages: state.messages,
          sendMessageStatus: SendStatus.initial,
          users: users.where((user) => user.id != currentUser['id']).toList()),
    );
  }

  Future<void> _onUploadImage(UploadImage event, Emitter emit) async {
    try {
      final String imageUrl = await chatRepository.uploadImage(event.image);

      await _onSendMessage(
          SendMessage(
              receiverId: event.receiverId,
              newMessage: imageUrl,
              type: 'media'),
          emit);
    } catch (error) {
      emit(state.copyWith(sendMessageStatus: SendStatus.failure));
    }
  }
}
