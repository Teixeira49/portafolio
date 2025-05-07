import 'dart:convert';
import 'package:flutter/services.dart';

import '../../models/entities_model/chat_model.dart';
import '../../models/entities_model/message_model.dart';
import '../../models/params/chat_selector_params.dart';

abstract class GetChatMessagesDatasource {
  /// Get the messages of a chat.
  ///
  /// **Returns:**
  /// - A [Future] of [List<MessageModel>].
  Future<ChatModel> getChatMessages(ChatSelectorParams params);
}

class GetChatMessagesDatasourceImpl implements GetChatMessagesDatasource {
  @override
  Future<ChatModel> getChatMessages(ChatSelectorParams params) async {
    try {
      String response = await rootBundle.loadString('data/chats.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      final messagesJson = data["chats"][params.chatName];
      if (messagesJson["messages"] != null) {
        final messages = List<MessageModel>.from(
          messagesJson["messages"].map(
            (message) => MessageModel.fromJson(message),
          ),
        );
        return ChatModel(
          id: messagesJson["id"],
          name: messagesJson["name"],
          messages: messages,
        );
      } else {
        throw Exception('Chat not found');
      }
    } catch (e) {
      throw Exception('Failed to load chat messages: $e');
    }
  }
}
