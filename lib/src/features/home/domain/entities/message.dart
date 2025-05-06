
class Message {
  final String id;
  final String content;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Message(id: $id, content: $content, timestamp: $timestamp)';
  }
}