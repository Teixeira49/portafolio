
import '../../data/models/params/chat_selector_params.dart';
import '../entities/message.dart';
import '../repositories/home_repository.dart';

class GetMessages {
  final IHomeRepository messageRepository;

  GetMessages(this.messageRepository);

  Future<List<Message>> call(ChatSelectorParams params) async {
    try {
      return await messageRepository.getMessages(params);
    } catch (e) {
      rethrow;
    }
  }
}