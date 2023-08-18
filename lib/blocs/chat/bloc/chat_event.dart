part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  const SendMessage(
      {required this.receiverId, required this.newMessage, required this.type});

  final String receiverId;
  final String newMessage;
  final String type;

  @override
  List<Object> get props => [receiverId, newMessage, type];
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

class UploadImage extends ChatEvent {
  const UploadImage({required this.image, required this.receiverId});

  final File image;
  final String receiverId;

  @override
  List<Object> get props => [image, receiverId];
}
