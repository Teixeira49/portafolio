part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {

  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessages extends ChatEvent {
  const GetChatMessages(this.chatName);
  final String chatName;
}