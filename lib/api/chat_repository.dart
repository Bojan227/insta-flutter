import 'dart:io';

import '../models/firebase_user.dart';
import '../models/message.dart';

abstract class IChatRepository {
  Future<void> sendMessage(String chatRoomId, Message message);
  Stream<List<Message>> getMessages(String chatRoomId);
  Stream<List<FirebaseUser>> getUsers();
  Future<String> uploadImage(File image);
}
