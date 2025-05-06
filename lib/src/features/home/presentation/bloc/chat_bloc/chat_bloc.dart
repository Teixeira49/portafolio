import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/params/chat_selector_params.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/use_cases/get_messages.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  ChatBloc({
    required GetMessages getMessages,
  }) : _getMessages = getMessages,
        super(const ChatState()) {
    on<GetChatMessages>(_getChatMessages);
  }

  final GetMessages _getMessages;

  FutureOr<void> _getChatMessages(
    GetChatMessages event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));

      final params = ChatSelectorParams(
        chatId: state.chatId,
      );

      final messages = await _getMessages.call(params);

      emit(
        state.copyWith(
          messages: messages,
          status: ChatStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}