part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({required this.messages});

  final List<dynamic> messages;

  @override
  List<Object> get props => [messages];
}
