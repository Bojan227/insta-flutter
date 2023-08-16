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
  const GetMessages({required this.userId, required this.otherId});

  final String userId;
  final String otherId;

  @override
  List<Object> get props => [userId, otherId];
}
