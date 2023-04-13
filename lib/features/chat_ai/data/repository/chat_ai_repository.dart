import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ChatAiRepository{
  Future<Either<Failure, Message>> sendMessage({
  String? model,
    String? prompt,
    int? temperature,
    int? maxTokens,
    double? frequencyPenalty,
    double? presencePenalty,
    List<String>? stop,
    List<NewMessageRequest>? messages,
    int? topP,
});

  Future<Either<Failure, ImageMessage>> fetchImageMessage({
    String? prompt,
    int? n,
    String? size,
    String? user,
    String? responseFormat,
});
}