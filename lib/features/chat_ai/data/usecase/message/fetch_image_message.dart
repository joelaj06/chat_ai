import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/core/usecase/usecase.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_image_request.dart';
import 'package:dartz/dartz.dart';

class FetchImageMessage implements UseCase<ImageMessage, MessageImageRequest>{
  FetchImageMessage({required this.chatAiRepository});

  final ChatAiRepository chatAiRepository;
  @override
  Future<Either<Failure, ImageMessage>> call(MessageImageRequest request) {
   return chatAiRepository.fetchImageMessage(
     responseFormat: request.responseFormat,
     user: request.user,
     size: request.size,
     n: request.n,
     prompt: request.prompt,
   );
  }

}