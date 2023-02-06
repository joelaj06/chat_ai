import 'package:chat_ai/features/chat_ai/data/usecase/message/send_message.dart';
import 'package:chat_ai/features/chat_ai/presentation/chat/getx/chat_controller.dart';
import 'package:get/get.dart';

class ChatBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController(
      sendMessage: SendMessage(
        chatAiRepository: Get.find(),
      ),
    ));
  }

}