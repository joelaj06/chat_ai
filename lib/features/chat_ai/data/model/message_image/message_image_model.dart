// ignore_for_file: invalid_annotation_target

import 'package:chat_ai/features/chat_ai/data/model/message_image/image_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_image_model.freezed.dart';

part 'message_image_model.g.dart';

@freezed
class ImageMessage with _$ImageMessage {
  const factory ImageMessage({
    int? created,
   List<ImageData>? data,

  }) = _ImageMessage;

  const ImageMessage._();

  factory ImageMessage.fromJson(Map<String, dynamic> json) => _$ImageMessageFromJson(json);

/*factory ImageMessage.empty() => const Choice(
id: 0
);*/
}
