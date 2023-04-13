import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/core/utils/repository.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_remote_repository.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_message_request.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_image_request.dart';
import 'package:dartz/dartz.dart';

import '../request/message_request.dart';

class ChatAiRepositoryImpl extends Repository implements ChatAiRepository {
  ChatAiRepositoryImpl({required this.chatAiRemoteRepository});

  final ChatAiRemoteRepository chatAiRemoteRepository;

  @override
  Future<Either<Failure, Message>> sendMessage(
      { String? model,
        String? prompt,
        int? temperature,
        int? maxTokens,
        double? frequencyPenalty,
        double? presencePenalty,
        List<String>? stop,
        List<NewMessageRequest>? messages,
        int? topP,
      }) {
    return makeRequest(chatAiRemoteRepository.sendMessage(NewChatMessageRequest(
        model: model,
        messages: messages
       )));
  }

  @override
  Future<Either<Failure, ImageMessage>> fetchImageMessage({String? prompt, int? n, String? size, String? user, String? responseFormat}) {
    return makeRequest(chatAiRemoteRepository.fetchMessageImage(
      MessageImageRequest(
        prompt: prompt,
        n: n,
        size: size,
        user: user,
        responseFormat: responseFormat,
      )
    ));
  }
}
