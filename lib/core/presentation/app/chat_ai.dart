import 'package:chat_ai/core/presentation/routes/app_routes.dart';
import 'package:chat_ai/core/presentation/routes/pages.dart';
import 'package:chat_ai/core/presentation/theme/app_theme.dart';
import 'package:chat_ai/main_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAi extends StatelessWidget {
  const ChatAi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Ai',
      initialBinding: MainBindings(),
      getPages: Pages.pages,
      initialRoute: AppRoutes.chat,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
