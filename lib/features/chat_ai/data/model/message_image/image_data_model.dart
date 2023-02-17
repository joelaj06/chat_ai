// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_data_model.freezed.dart';

part 'image_data_model.g.dart';

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    String? url,
  }) = _ImageData;

  const ImageData._();

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);

/*factory ImageData.empty() => const Choice(
id: 0
);*/
}
