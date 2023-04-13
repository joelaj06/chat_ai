import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_message_request.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_image_request.dart';

abstract class ChatAiRemoteRepository{
  Future<Message> sendMessage(NewChatMessageRequest chatRequest);
  Future<ImageMessage> fetchMessageImage(MessageImageRequest imageRequest);
}