import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/sql_helper.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/model/message_image/message_image_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_message/chat_message_request.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_request.dart';
import 'package:chat_ai/features/chat_ai/data/request/message_image_request.dart';
import 'package:chat_ai/features/chat_ai/data/usecase/message/fetch_image_message.dart';
import 'package:chat_ai/features/chat_ai/data/usecase/message/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../data/model/chat_message/chat_message_model.dart';

class ChatController extends GetxController {
  ChatController({
    required this.sendMessage,
    required this.fetchImageMessage,
  });

  final SendMessage sendMessage;
  final FetchImageMessage fetchImageMessage;

  // reactive variables
  Rx<TextEditingController> messageTextEditingController =
      TextEditingController().obs;
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxString senderMessage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool activateRecord = false.obs;
  RxBool isRecording = false.obs;
  RxString recordedText = ''.obs;
  RxBool speechEnabled = false.obs;


  final SpeechToText speechToText = SpeechToText();
  static const String _defaultText = 'Tap on the record button to start';

  @override
  void onInit() {
   // SqlHelper.alterTable(DbTables.chatMessages, 'date');
    getAllChatMessages();
    recordedText(_defaultText);
    _initSpeech();
    super.onInit();
  }

  @override
  void dispose() {
    messageTextEditingController.value.dispose();
    super.dispose();
  }

  void getAllChatMessages() async{
    final List<ChatMessage> messages = await SqlHelper.fetchChatMessages();
  //  chatMessages(messages);
    chatMessages.clear();
    for(final ChatMessage message in messages){
      chatMessages.insert(0, message);
    }
  }

  void getMessageImage(String prompt) async {
    isLoading(true);
    final Either<Failure, ImageMessage> failureOrImageMessage =
        await fetchImageMessage(MessageImageRequest(
            size: '1024x1024',
            prompt: prompt,
            n: 1,
            user: '',
            responseFormat: 'url'));
    failureOrImageMessage.fold(
      (Failure failure) {
        isLoading(false);
        debugPrint(failure.message);
        Get.snackbar('Error', failure.message);
      },
      (ImageMessage imageMessage) {
        isLoading(false);
        final String imageUrl = imageMessage.data?.first.url ?? '';
        if (imageUrl.isEmpty) {
          Get.snackbar('Error', 'Sorry could not get the image, try again');
        } else {
          final ChatMessageRequest messageRequest = ChatMessageRequest(
            isImage: true,
            text: imageUrl,
            sender: Sender.bot.name,
            createdAt: DateTime.now().toIso8601String(),
          );
          SqlHelper.addMessage(messageRequest);
          getAllChatMessages();
        }
      },
    );
  }



  void sendTheMessage(String message) async {
    final List<String> stop = <String>['Human:', 'AI:'];
    isLoading(true);
    print(message);
    final Either<Failure, Message> failureOrMessage = await sendMessage(
        MessageRequest(
            model: 'text-davinci-003',
            prompt: message,
            topP: 1,
            temperature: 0,
            maxTokens: 200,
            frequencyPenalty: 0.0,
            presencePenalty: 0.0,
            stop: stop));

    failureOrMessage.fold(
      (Failure failure) {
        isLoading(false);
        debugPrint(failure.message);
        Get.snackbar('Error', failure.message);
      },
      (Message message) {
        isLoading(false);
         String text = message.choices?.first.text ?? '...';

        if(text.contains('[Your name]')){
          text = text.replaceAll('[Your name]', 'Emy');
        }
        final ChatMessageRequest messageRequest = ChatMessageRequest(
          isImage: false,
          text: text,
          sender: Sender.bot.name,
          createdAt: DateTime.now().toIso8601String(),
        );
        SqlHelper.addMessage(messageRequest);
        getAllChatMessages();
      },
    );
  }

  // adds message to list and send to server
  void onMessageSend({bool isImage = false}) async {
    if (messageTextEditingController.value.text.isEmpty ||
        messageTextEditingController.value.text == _defaultText) {
      return;
    }

    final ChatMessageRequest messageRequest = ChatMessageRequest(
      isImage: isImage,
      text: messageTextEditingController.value.text,
      sender: Sender.user.name,
      createdAt: DateTime.now().toIso8601String(),
    );

    await SqlHelper.addMessage(messageRequest);
    getAllChatMessages();

    isImage ? getMessageImage(messageTextEditingController.value.text):
    sendTheMessage(messageTextEditingController.value.text);
    messageTextEditingController.value.clear();
  }


  // initialize speech to text. Should be called once.
  void _initSpeech() async {
    final bool isSpeechEnabled = await speechToText.initialize(
      //  finalTimeout:
    );
    speechEnabled(isSpeechEnabled);
  }

  void startListening() async {
    isRecording(true);
    if (speechEnabled.value) {
      await speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(minutes: 3),
      );
    }
  }

  //speech callback
  void _onSpeechResult(SpeechRecognitionResult result) {
    recordedText(result.recognizedWords);
  }

  void stopListening() async {
    await speechToText.stop();
    isRecording(false);
  }

  void onSpeechTextMessageSend() {
    isRecording(false);
    messageTextEditingController.value.text = recordedText.value;
    onMessageSend();
  //  messageTextEditingController.value.clear();
    resetSpeechText();
  }


  void resetSpeechText() {
    recordedText(_defaultText);
  }

  void onActivateRecordEnabled(bool enabled) {
    activateRecord(enabled);
  }
}

enum Sender { user, bot }


