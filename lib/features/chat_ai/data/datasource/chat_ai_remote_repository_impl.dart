import 'package:chat_ai/core/utils/app_http_client.dart';
import 'package:chat_ai/core/utils/environment.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_endpoints.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_remote_repository.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_request.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_image_request.dart';

class ChatAiRemoteRepositoryImpl implements ChatAiRemoteRepository {
  final AppHTTPClient _client = AppHTTPClient();

  @override
  Future<Message> sendMessage(MessageRequest chatRequest) async {
    final Map<String, dynamic> json = await _client.post(
      chatBaseUrl,
      ChatAiEndpoints.completions,
      body: chatRequest.toJson(),
    );
    return Message.fromJson(json);
  }

  @override
  Future<ImageMessage> fetchMessageImage(
      MessageImageRequest imageRequest) async {
    final Map<String, dynamic> json = await _client.post(
      chatBaseUrl,
      ChatAiEndpoints.generateImages,
      body: imageRequest.toJson(),
    );
    return ImageMessage.fromJson(json);
  }

}
