import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_request.dart';

abstract class ChatAiRemoteRepository{
  Future<Message> sendMessage(MessageRequest chatRequest);
}