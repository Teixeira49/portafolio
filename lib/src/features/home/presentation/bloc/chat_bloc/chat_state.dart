part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == ChatStatus.initial;
  bool get isLoading => this == ChatStatus.loading;
  bool get isLoaded => this == ChatStatus.loaded;
  bool get isError => this == ChatStatus.error;
}

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.chatId = 0,
    this.chatName = '',
    this.chatRoute = '',
    this.messages = const [],
    this.errorMessage,
  });

  final ChatStatus status;
  final int chatId;
  final String chatName;
  final String chatRoute;
  final List<Message> messages;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, chatId, chatName, chatRoute, messages, errorMessage];

  ChatState copyWith({
    ChatStatus? status,
    int? chatId,
    String? chatName,
    String? chatRoute,
    List<Message>? messages,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatId: chatId ?? this.chatId,
      chatName: chatName ?? this.chatName,
      chatRoute: chatRoute ?? this.chatRoute,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}