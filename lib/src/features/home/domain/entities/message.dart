
class Message {
  final int id;
  final String member;
  final String text;
  //final DateTime timestamp;

  Message({
    required this.id,
    required this.member,
    required this.text,
    //required this.timestamp,
  });

  @override
  String toString() {
    return 'Message(id: $id, member: $member, content: $text)'; //, timestamp: $timestamp
  }
}