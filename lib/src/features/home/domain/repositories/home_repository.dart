import '../../data/models/entities_model/chat_model.dart';
import '../../data/models/params/chat_selector_params.dart';

abstract class IHomeRepository {
  /// Get the current user.
  ///
  /// **Returns:**
  /// - A [Future] of [UserModel].
  Future<ChatModel> getMessages(ChatSelectorParams params);
}