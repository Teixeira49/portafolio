
class ChatSelectorParams {
  final int chatId;

  const ChatSelectorParams({
    required this.chatId,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
    };
  }
}