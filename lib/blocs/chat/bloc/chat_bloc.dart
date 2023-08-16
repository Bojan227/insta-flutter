import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../models/message.dart';
import '../../../storage/shared_preferences.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SharedPreferencesConfig storage;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatBloc({required this.storage}) : super(const ChatState(messages: [])) {
    on<SendMessage>(_onSendMessage);
    on<GetMessages>(_onGetMessages);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter emit) async {
    final token = storage.getString('accessToken');

    final QuerySnapshot<Object?> currentUser =
        await users.where('token', isEqualTo: token).limit(1).get();
    final Timestamp timestamp = Timestamp.now();

    if (currentUser.size > 0) {
      QueryDocumentSnapshot<Object?> documentSnapshot = currentUser.docs[0];
      var data = documentSnapshot.data() as Map<String, dynamic>;

      final Message message = Message(
          senderId: data['id'],
          senderUsername: data['username'],
          receiverId: event.receiverId,
          message: event.newMessage,
          timestamp: timestamp);

      List<String> ids = [data['id'], event.receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toMap());

      // ... print other fields
    } else {
      print("No user found with the given token.");
    }
  }

  Stream<QuerySnapshot> _onGetMessages(GetMessages event, Emitter emit) {
    List<String> ids = [event.userId, event.otherId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
