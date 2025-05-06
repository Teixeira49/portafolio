import '../../data/models/params/chat_selector_params.dart';
import '../entities/message.dart';

abstract class IHomeRepository {
  /// Get the current user.
  ///
  /// **Returns:**
  /// - A [Future] of [UserModel].
  Future<List<Message>> getMessages(ChatSelectorParams params);
}