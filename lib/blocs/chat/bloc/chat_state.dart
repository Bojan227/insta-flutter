part of 'chat_bloc.dart';

enum SendStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  const ChatState(
      {required this.messages,
      required this.sendMessageStatus,
      required this.users});

  final List<Message> messages;
  final List<FirebaseUser> users;

  final SendStatus sendMessageStatus;

  ChatState copyWith(
      {List<Message>? messages,
      SendStatus? sendMessageStatus,
      List<FirebaseUser>? users}) {
    return ChatState(
        messages: messages ?? this.messages,
        users: users ?? this.users,
        sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus);
  }

  @override
  List<Object> get props => [messages];
}
