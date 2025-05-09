import 'package:portafolio/src/features/home/domain/repositories/home_repository.dart';

import '../datasource/local/get_chat_local_datasource.dart';
import '../models/entities_model/chat_model.dart';
import '../models/params/chat_selector_params.dart';

class HomeRepository implements IHomeRepository {

  HomeRepository({
    required GetChatMessagesDatasource getChatMessagesDatasource,
  }) : _getChatMessagesDatasource = getChatMessagesDatasource;

  final GetChatMessagesDatasource _getChatMessagesDatasource;

  @override
  Future<ChatModel> getMessages(ChatSelectorParams params) async {
    try {
      return await _getChatMessagesDatasource.getChatMessages(params);
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }
}