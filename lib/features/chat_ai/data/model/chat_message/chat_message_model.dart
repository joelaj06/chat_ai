// ignore_for_file: invalid_annotation_target

import 'package:chat_ai/features/chat_ai/presentation/chat/getx/chat_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';

part 'chat_message_model.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
     required String text,
    @JsonKey(name: 'is_image') required bool isImage,
    @JsonKey(name: 'created_at') String? createdAt,
    required Sender sender,
  }) = _ChatMessage;

  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

/*factory ChatMessage.empty() => const ChatMessage(
id: 0
);*/
}
