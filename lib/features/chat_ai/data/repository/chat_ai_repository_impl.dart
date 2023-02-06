import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/core/utils/repository.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_remote_repository.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_request.dart';
import 'package:dartz/dartz.dart';

class ChatAiRepositoryImpl extends Repository implements ChatAiRepository {
  ChatAiRepositoryImpl({required this.chatAiRemoteRepository});

  final ChatAiRemoteRepository chatAiRemoteRepository;

  @override
  Future<Either<Failure, Message>> sendMessage(
      {String? model,
      String? prompt,
      int? temperature,
      int? maxTokens,
      double? frequencyPenalty,
      double? presencePenalty,
      List<String>? stop,
      int? topP}) {
    return makeRequest(chatAiRemoteRepository.sendMessage(MessageRequest(
        model: model,
        maxTokens: maxTokens,
        prompt: prompt,
        temperature: temperature,
        stop: stop,
        presencePenalty: presencePenalty,
        frequencyPenalty: frequencyPenalty,
        topP: topP)));
  }
}
