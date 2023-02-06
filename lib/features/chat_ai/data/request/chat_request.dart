class MessageRequest {

  MessageRequest(
      {this.model,
        this.prompt,
        this.temperature,
        this.maxTokens,
        this.topP,
        this.frequencyPenalty,
        this.presencePenalty,
        this.stop});

  MessageRequest.fromJson(Map<String, dynamic> json) {
    model = json['model'] as String;
    prompt = json['prompt'] as String;
    temperature = json['temperature'] as int;
    maxTokens = json['max_tokens'] as int;
    topP = json['top_p'] as int;
    frequencyPenalty = json['frequency_penalty'] as double;
    presencePenalty = json['presence_penalty'] as double;
    stop = json['stop'] as List<String>;
  }
  String? model;
  String? prompt;
  int? temperature;
  int? maxTokens;
  int? topP;
  double? frequencyPenalty;
  double? presencePenalty;
  List<String>? stop;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['prompt'] = prompt;
    data['temperature'] = temperature;
    data['max_tokens'] = maxTokens;
    data['top_p'] = topP;
    data['frequency_penalty'] = frequencyPenalty;
    data['presence_penalty'] = presencePenalty;
    data['stop'] = stop;
    return data;
  }
}
