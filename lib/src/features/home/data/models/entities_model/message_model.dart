import '../../../domain/entities/message.dart';

class MessageModel extends Message {

  /// The [MessageModel] class is a model that represents a message.

  MessageModel({
    required super.id,
    required super.content,
    required super.timestamp,
  });

  /// Converts a [MessageModel] to a [Message].
  ///
  /// **Returns:**
  ///
  /// - A [Message].

  Message toEntity() {
    return Message(
      id: id,
      content: content,
      timestamp: timestamp,
    );
  }

  /// Converts a [Message] to a [MessageModel].
  ///
  /// **Returns:**
  ///
  /// - A [MessageModel].
  static MessageModel fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      content: message.content,
      timestamp: message.timestamp,
    );
  }

  /// Converts a [MessageModel] to a [Map<String, dynamic>].
///
  /// **Returns:**
  ///
  /// - A [Map<String, dynamic>].

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp,
    };
  }

  /// Converts a [Map<String, dynamic>] to a [MessageModel].
  ///
  /// **Returns:**
  ///
  /// - A [MessageModel].

  static MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }
}
