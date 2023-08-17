part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  const SendMessage({required this.receiverId, required this.newMessage});

  final String receiverId;
  final String newMessage;

  @override
  List<Object> get props => [receiverId, newMessage];
}

class GetMessages extends ChatEvent {
  const GetMessages({required this.receiverId});

  final String receiverId;

  @override
  List<Object> get props => [receiverId];
}

class GetOnlineUsers extends ChatEvent {
  const GetOnlineUsers();
}
