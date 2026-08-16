
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';
import '../repositories/chat_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository = getIt<ChatRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  ChatCubit() : super(ChatInitial());

  Future<void> loadChatList() async {
    emit(ChatLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ChatError(message: 'No internet connection.'));
        return;
      }

      final chats = await _chatRepository.getChatList();
      emit(ChatListLoaded(chats: chats));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> loadChatMessages(String chatId, {int page = 1}) async {
    emit(ChatLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ChatError(message: 'No internet connection.'));
        return;
      }

      final messages = await _chatRepository.getChatMessages(chatId, page: page);
      emit(ChatMessagesLoaded(messages: messages, chatId: chatId));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required String content,
    String? type,
  }) async {
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ChatError(message: 'No internet connection.'));
        return;
      }

      final message = await _chatRepository.sendMessage(
        chatId: chatId,
        content: content,
        type: type,
      );
      emit(MessageSent(message: message));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> markAsRead(String messageId) async {
    try {
      await _chatRepository.markAsRead(messageId);
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> loadUnreadCount() async {
    try {
      final count = await _chatRepository.getUnreadCount();
      emit(ChatUnreadCountLoaded(count: count));
    } catch (_) {
      // Silent fail
    }
  }

  void clearError() {
    if (state is ChatError) {
      emit(ChatInitial());
    }
  }

  void reset() {
    emit(ChatInitial());
  }
}