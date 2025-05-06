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
    this.messages = const [],
    this.errorMessage,
  });

  final ChatStatus status;
  final int chatId;
  final List<Message> messages;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, chatId, messages, errorMessage];

  ChatState copyWith({
    ChatStatus? status,
    int? chatId,
    List<Message>? messages,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatId: chatId ?? this.chatId,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}