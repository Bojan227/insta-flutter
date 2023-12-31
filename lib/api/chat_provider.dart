import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/firebase_user.dart';
import '../models/message.dart';

abstract class IChatProvider {
  Future<String> uploadImage(File image);
  Future<void> sendMessage(String chatRoomId, Message message);
  Stream<List<Message>> getMessages(String chatRoomId);
  Stream<List<FirebaseUser>> getUsers();
}

class ChatProvider implements IChatProvider {
  const ChatProvider({required this.firestore, required this.firestorage});

  final FirebaseFirestore firestore;
  final FirebaseStorage firestorage;
  @override
  Future<void> sendMessage(String chatRoomId, Message message) async {
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());
  }

  @override
  Stream<List<Message>> getMessages(String chatRoomId) async* {
    yield* firestore
        .collection('chat_rooms')
        .withConverter(
            fromFirestore: (snapshot, _) => Message.fromMap(snapshot.data()!),
            toFirestore: (message, _) => message.toMap())
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((snapshot) => Message.fromMap(snapshot.data()))
              .toList(),
        );
  }

  @override
  Stream<List<FirebaseUser>> getUsers() async* {
    yield* firestore
        .collection('users')
        .withConverter(
            fromFirestore: (snapshot, _) =>
                FirebaseUser.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap())
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  @override
  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference reference = firestorage.ref().child(fileName);
    TaskSnapshot uploadTask = await reference.putFile(image);

    return await uploadTask.ref.getDownloadURL();
  }
}
