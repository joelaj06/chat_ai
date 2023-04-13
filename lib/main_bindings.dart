import 'package:chat_ai/core/presentation/theme/theme_manager.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_remote_repository.dart';
import 'package:chat_ai/features/chat_ai/data/datasource/chat_ai_remote_repository_impl.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository.dart';
import 'package:chat_ai/features/chat_ai/data/repository/chat_ai_repository_impl.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ThemeManagerController>(ThemeManagerController());
    Get.put<ChatAiRemoteRepository>(ChatAiRemoteRepositoryImpl());
    Get.put<ChatAiRepository>(ChatAiRepositoryImpl(
        chatAiRemoteRepository: Get.find(),
    ));
  }

}