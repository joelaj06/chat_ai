// ignore_for_file: invalid_annotation_target

import 'package:chat_ai/features/chat_ai/data/request/message_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_request.freezed.dart';

part 'chat_message_request.g.dart';

@freezed
class NewChatMessageRequest with _$NewChatMessageRequest {
  const factory NewChatMessageRequest({
   String? model,
    List<NewMessageRequest>? messages,
  }) = _NewChatMessageRequest;

  const NewChatMessageRequest._();

  factory NewChatMessageRequest.fromJson(Map<String, dynamic> json) => _$NewChatMessageRequestFromJson(json);


}
