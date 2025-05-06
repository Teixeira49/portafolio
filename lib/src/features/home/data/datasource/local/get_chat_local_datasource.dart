import '../../models/entities_model/message_model.dart';
import '../../models/params/chat_selector_params.dart';

abstract class GetChatMessagesDatasource {
  /// Get the messages of a chat.
  ///
  /// **Returns:**
  /// - A [Future] of [List<MessageModel>].
  Future<List<MessageModel>> getChatMessages(ChatSelectorParams params);
}

class GetChatMessagesDatasourceImpl implements GetChatMessagesDatasource {
  @override
  Future<List<MessageModel>> getChatMessages(ChatSelectorParams params) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    return [
      MessageModel(
        id: '1',
        content: 'Hello, how are you?',
        timestamp: DateTime.now(),
      ),
      MessageModel(
        id: '2',
        content: 'This is a test message.',
        timestamp: DateTime.now(),
      ),
      MessageModel(
        id: '3',
        content: 'Flutter is awesome!',
        timestamp: DateTime.now(),
      ),
    ];
  }
}
