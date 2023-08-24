part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState(
      {required this.messages,
      required this.sendMessageStatus,
      required this.users});

  final List<Message> messages;
  final List<FirebaseUser> users;

  final Status sendMessageStatus;

  ChatState copyWith(
      {List<Message>? messages,
      Status? sendMessageStatus,
      List<FirebaseUser>? users}) {
    return ChatState(
        messages: messages ?? this.messages,
        users: users ?? this.users,
        sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus);
  }

  @override
  List<Object> get props => [messages];
}
