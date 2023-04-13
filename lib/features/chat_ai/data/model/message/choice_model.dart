// ignore_for_file: invalid_annotation_target

import 'package:chat_ai/features/chat_ai/data/request/message_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_model.freezed.dart';

part 'choice_model.g.dart';

@freezed
class Choice with _$Choice {
  const factory Choice({
    String? text,
    int? index,
    String? logprops,
    NewMessageRequest? message,
    @JsonKey(name: 'finish_reason') String? finishReason,
  }) = _Choice;

  const Choice._();

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

/*factory Choice.empty() => const Choice(
id: 0
);*/
}
