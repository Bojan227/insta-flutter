import 'package:pettygram_flutter/api/chat_repository.dart';
import 'package:pettygram_flutter/models/firebase_user.dart';

import '../models/message.dart';
import 'chat_provider.dart';

class ChatRepository implements IChatRepository {
  const ChatRepository({required this.provider});

  final ChatProvider provider;

  @override
  Future<void> sendMessage(String chatRoomId, Message message) async {
    return await provider.sendMessage(chatRoomId, message);
  }

  @override
  Stream<List<Message>> getMessages(String chatRoomId) async* {
    yield* provider.getMessages(chatRoomId);
  }

  @override
  Stream<List<FirebaseUser>> getUsers() async* {
    yield* provider.getUsers();
  }
}
