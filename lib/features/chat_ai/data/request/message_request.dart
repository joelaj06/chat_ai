// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_request.freezed.dart';

part 'message_request.g.dart';

@freezed
class NewMessageRequest with _$NewMessageRequest {
  const factory NewMessageRequest({
    String? role,
    String? content,
  }) = _NewMessageRequest;

  const NewMessageRequest._();

  factory NewMessageRequest.fromJson(Map<String, dynamic> json) => _$NewMessageRequestFromJson(json);


}
