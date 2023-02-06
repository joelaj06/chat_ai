// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'usage_model.freezed.dart';

part 'usage_model.g.dart';

@freezed
class Usage with _$Usage {
  const factory Usage({
    @JsonKey(name: 'prompt_tokens') int? promptTokens,
    @JsonKey(name: 'completion_tokens') int? completionTokens,
    @JsonKey(name: 'total_tokens') int? totalTokens,
  }) = _Usage;

  const Usage._();

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);

/*factory Usage.empty() => const Usage(
id: 0
);*/
}
