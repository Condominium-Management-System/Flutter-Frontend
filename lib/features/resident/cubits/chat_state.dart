
import 'package:equatable/equatable.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatListLoaded extends ChatState {
  final List<ChatModel> chats;

  const ChatListLoaded({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class ChatMessagesLoaded extends ChatState {
  final List<MessageModel> messages;
  final String chatId;

  const ChatMessagesLoaded({
    required this.messages,
    required this.chatId,
  });

  @override
  List<Object?> get props => [messages, chatId];
}

class MessageSent extends ChatState {
  final MessageModel message;

  const MessageSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatUnreadCountLoaded extends ChatState {
  final int count;

  const ChatUnreadCountLoaded({required this.count});

  @override
  List<Object?> get props => [count];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}