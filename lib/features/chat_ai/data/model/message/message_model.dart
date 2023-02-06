// ignore_for_file: invalid_annotation_target

import 'package:chat_ai/features/chat_ai/data/model/message/usage_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'choice_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
      String? id,
      String? object,
      int? created,
      String? model,
      List<Choice>? choices,
      Usage? usage,

  }) = _Message;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

 /* factory Message.empty() => const Message(
      id: 0
  );*/
}
