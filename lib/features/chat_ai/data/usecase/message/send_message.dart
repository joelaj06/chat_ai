import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/core/usecase/usecase.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_message_request.dart';
import 'package:dartz/dartz.dart';

class SendMessage implements UseCase<Message, NewChatMessageRequest>{
  SendMessage({required this.chatAiRepository});

  final ChatAiRepository chatAiRepository;
  @override
  Future<Either<Failure, Message>> call(NewChatMessageRequest request) {
    return chatAiRepository.sendMessage(
     /* topP: request.topP!,
      frequencyPenalty: request.frequencyPenalty,
      presencePenalty: request.presencePenalty,
      stop: request.stop,
      temperature: request.temperature,
      prompt: request.prompt,
      maxTokens: request.maxTokens,*/
      messages: request.messages,
      model: request.model,
    );
  }

}