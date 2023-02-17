// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_image_request.freezed.dart';

part 'message_image_request.g.dart';

@freezed
class MessageImageRequest with _$MessageImageRequest {
  const factory MessageImageRequest({
    String? prompt,
    int? n,
    String? size,
    @JsonKey(name: 'response_format') String? responseFormat,
    String? user,
  }) = _MessageImageRequest;

  const MessageImageRequest._();

  factory MessageImageRequest.fromJson(Map<String, dynamic> json) => _$MessageImageRequestFromJson(json);


}
