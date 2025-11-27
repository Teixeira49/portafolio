class ChatSelectorParams {
  final String chatName;

  const ChatSelectorParams({required this.chatName});

  Map<String, dynamic> toJson() {
    return {'chatName': chatName};
  }
}
