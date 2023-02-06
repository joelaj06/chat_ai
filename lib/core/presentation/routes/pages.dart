import 'package:chat_ai/core/presentation/routes/app_routes.dart';
import 'package:chat_ai/features/chat_ai/presentation/chat/getx/chat_bindings.dart';
import 'package:chat_ai/features/chat_ai/presentation/chat/screen/chart_screen.dart';
import 'package:get/get.dart';

class Pages {
  static List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: ChatBindings()
    )
  ];
}
