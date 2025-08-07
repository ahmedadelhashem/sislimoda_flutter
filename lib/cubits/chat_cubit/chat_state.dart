part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatLoaded extends ChatState {
  final List<ChatModel> chats;
  final ChatModel selectedChat;
  final int timeStamp;
  final int unreadMessages;
  const ChatLoaded( {
    required this.chats,
    required this.selectedChat,
    required this.timeStamp,
    required this.unreadMessages,
  });
  @override
  List<Object> get props => [timeStamp];
}

final class ChatFailed extends ChatState {
  @override
  List<Object> get props => [];
}
