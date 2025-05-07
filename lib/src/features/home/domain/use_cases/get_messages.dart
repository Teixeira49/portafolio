import '../../data/models/entities_model/chat_model.dart';
import '../../data/models/params/chat_selector_params.dart';
import '../repositories/home_repository.dart';

class GetMessagesUseCase {
  final IHomeRepository messageRepository;

  GetMessagesUseCase(this.messageRepository);

  Future<ChatModel> call(ChatSelectorParams params) async {
    try {
      return await messageRepository.getMessages(params);
    } catch (e) {
      rethrow;
    }
  }
}