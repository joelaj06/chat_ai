// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_request.freezed.dart';

part 'chat_message_request.g.dart';

@freezed
class ChatMessageRequest with _$ChatMessageRequest {
  const factory ChatMessageRequest({
    required String text,
    required bool isImage,
    required String createdAt,
    required String sender,
  }) = _ChatMessageRequest;

  const ChatMessageRequest._();

  factory ChatMessageRequest.fromJson(Map<String, dynamic> json) => _$ChatMessageRequestFromJson(json);

/*factory ChatMessageRequest.empty() => const ChatMessageRequest(
id: 0
);*/
}
