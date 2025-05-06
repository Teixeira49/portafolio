import '../../../domain/entities/chat.dart';
import 'message_model.dart';

class ChatModel extends Chat {
  /// The [ChatModel] class is a model that represents a chat.
  ///
  /// **Parameters:**
  ///
  /// - [id]: The id of the chat.
  /// - [name]: The name of the chat.
  /// - [messages]: The messages of the chat.
  //final DateTime lastMessageTime;

  ChatModel({
    required super.id,
    required super.name,
    required super.messages,
    //required this.lastMessageTime,
  });

  /// Converts a [ChatModel] to a [Chat].
  ///
  /// **Returns:**
  ///
  /// - A [Chat].

  Chat toEntity() {
    return Chat(
      id: id,
      name: name,
      messages: messages,
      //lastMessageTime: lastMessageTime,
    );
  }

  /// Converts a [Chat] to a [ChatModel].
  ///
  /// **Returns:**
  ///
  /// - A [ChatModel].

  static ChatModel fromEntity(Chat chat) {
    return ChatModel(
      id: chat.id,
      name: chat.name,
      messages: chat.messages,
      //lastMessageTime: chat.lastMessageTime,
    );
  }

  /// Converts a [ChatModel] to a [Map<String, dynamic>].
  ///
  /// **Returns:**
  ///
  /// - A [Map<String, dynamic>].

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'messages':
          messages
              .map((message) => (message as MessageModel).toJson())
              .toList(),
      //'lastMessageTime': lastMessageTime.toIso8601String(),
    };
  }

  /// Converts a [Map<String, dynamic>] to a [ChatModel].
  ///
  /// **Returns:**
  ///
  /// - A [ChatModel].

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      messages:
          (json['messages'] as List)
              .map((message) => MessageModel.fromJson(message))
              .toList(),
      //lastMessageTime: DateTime.parse(json['lastMessageTime']),
    );
  }
}
