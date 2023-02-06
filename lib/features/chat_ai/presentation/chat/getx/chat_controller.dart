import 'package:chat_ai/core/error/failure.dart';
import 'package:chat_ai/core/presentation/widget/chart_message.dart';
import 'package:chat_ai/features/chat_ai/data/model/message/message_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_request.dart';
import 'package:chat_ai/features/chat_ai/data/usecase/message/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController({required this.sendMessage});

  final SendMessage sendMessage;

  // reactive variables
  Rx<TextEditingController> messageTextEditingController =
      TextEditingController().obs;
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxString senderMessage = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    messageTextEditingController.value.dispose();
    super.dispose();
  }

  void sendTheMessage(String message) async {
    final List<String> stop = <String>['Human:', 'AI:'];
    isLoading(true);
    final Either<Failure, Message> failureOrMessage = await sendMessage(
        MessageRequest(
            model: 'text-davinci-003',
            prompt: message,
            topP: 1,
            temperature: 0,
            maxTokens: 100,
            frequencyPenalty: 0.0,
            presencePenalty: 0.0,
            stop: stop));

    failureOrMessage.fold(
      (Failure failure) {
        isLoading(false);
       Get.snackbar('Error', 'Failed to get response');
      },
      (Message message) {
        isLoading(false);
        final ChatMessage chatMessage = ChatMessage(
          textMessage: message.choices?[0].text ?? '...',
          sender: Sender.bot.name,
        );
        chatMessages.insert(0, chatMessage);
      },
    );
  }

  void onMessageSend() async {
    final ChatMessage chatMessage = ChatMessage(
      textMessage: messageTextEditingController.value.text,
      sender: Sender.user.name,
    );
    chatMessages.insert(0, chatMessage);
    sendTheMessage(messageTextEditingController.value.text);
    messageTextEditingController.value.clear();
  }
}

enum Sender { user, bot }
