import 'message.dart';

class Chat {
  final String id;
  final String name;
  final List<Message> messages;
  //final DateTime lastMessageTime;

  Chat({
    required this.id,
    required this.name,
    required this.messages,
    //required this.lastMessageTime,
  });

  @override
  String toString() {
    return 'Chat(id: $id, name: $name, lastMessage: $messages)'; //, lastMessageTime: $lastMessageTime
  }
}