import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:chat_ai/core/utils/base_64.dart';
import 'package:chat_ai/core/utils/data_formatter.dart';
import 'package:chat_ai/features/chat_ai/presentation/chat/getx/chat_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/presentation/widget/app_alerts.dart';
import '../../../data/model/chat_message/chat_message_model.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isDarkMode(Get.isDarkMode);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/robot.png'),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Bot',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => Text(
                          controller.isLoading.value ? 'typing' : 'Online',
                          style: TextStyle(
                              fontStyle: controller.isLoading.value
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              color: Colors.grey.shade600,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.toggleTheme();
                  },
                  icon: Obx(
                    () => Icon(
                      controller.isDarkMode.value
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Flexible(
            child: Obx(() {
              final Map<String, List<ChatMessage>> groupByDate = groupBy(
                controller.chatMessages,
                (ChatMessage message) => message.createdAt!.substring(0, 10),
              );
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: groupByDate.values.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  final String key = groupByDate.keys.elementAt(index);
                  final ChatMessage message = groupByDate[key]![index];

                  return Column(
                    children: <Widget>[
                      _getGroupSeparator(message),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: groupByDate[key]!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: ValueKey<int>(groupByDate[key]![index].id),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  final bool? result =
                                      await AppAlerts().alertWithButtons(
                                    context: context,
                                    title: 'Are you sure?',
                                    desc: 'This operation is not reversible',
                                    onLeftButtonPressed: () =>
                                        Navigator.pop(context, false),
                                    onRightButtonPressed: () =>
                                        Navigator.pop(context, true),
                                    alertType: AlertType.warning,
                                  );
                                  if (result == null || result == false) {
                                    return false;
                                  }
                                  return true;
                                },
                                onDismissed: (DismissDirection direction) {
                                  controller.deleteMessage(context,
                                      groupByDate[key]![index].id, index);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    print(groupByDate[key]![index].id);
                                  },
                                  child: Obx(
                                    () => _buildChatListTile(
                                        context,
                                        groupByDate[key]![index],
                                        controller.isDarkMode.value,
                                        index),
                                  ),
                                ),
                              ),
                            );
                          }),
                      /*Column(
                        children: List<Widget>.generate(groupByDate[key]!.length , (int index) {
                          return _buildChatListTile(context, groupByDate[key]![index]);
                        }) ,
                      )*/
                    ],
                  );
                },
              );
            }),
          ),
          _buildTextComposer(context),
        ],
      ),
    );
  }

  Widget _getGroupSeparator(ChatMessage message) {
    final DateTime element = DateTime.parse(message.createdAt!);
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DataFormatter.formatDateToString(
              element.toIso8601String(),
            ),
            // '${element.day}. ${element.month}, ${element.year}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatListTile(
    BuildContext context,
    ChatMessage message,
    bool isDarkTheme,
    int index,
  ) {
    final bool isUser = message.sender == Sender.user.name;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        if (!message.isImage || isUser)
          _messageBubble(isUser, context, isDarkTheme, message)
        else
          Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    _messageBubble(
                      isUser,
                      context,
                      isDarkTheme,
                      message,
                    ),
                    Obx(
                      () => Positioned.fill(
                        child: controller.isImageLoading.value &&
                                controller.selectedImage.value == index
                            ? Container(
                                decoration: BoxDecoration(
                                color: Colors.black54.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: isUser ? const Radius.circular(10) : Radius.zero,
                                    topRight: isUser ? Radius.zero : const Radius.circular(10),
                                    bottomLeft: const Radius.circular(10),
                                    bottomRight: const Radius.circular(10),
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.selectedImage(index);
                  controller.saveImage(message.text);
                },
                icon: const Icon(Icons.download_for_offline),
              )
            ],
          ),
        Text(
          DateTime.parse(message.createdAt!).formatTime(),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Container _messageBubble(bool isUser, BuildContext context, bool isDarkTheme,
      ChatMessage message) {
    return Container(
      // width: width,
      decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).primaryColor
              : isDarkTheme
                  ? Colors.black54.withOpacity(0.3)
                  : Colors.grey.shade300.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: isUser ? const Radius.circular(10) : Radius.zero,
            topRight: isUser ? Radius.zero : const Radius.circular(10),
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: message.isImage && !isUser
            ? /*Image.memory(
                  Base64Convertor().base64toImage(message.text),
                )*/
            GestureDetector(
                onDoubleTap: () {},
                child: Image.network(
                  message.text,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress != null) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    return SizedBox(
                      child: child,
                    );
                  },
                  errorBuilder: (BuildContext context, Object object,
                          StackTrace? stackTrace) =>
                      const Text('Cannot load image'),
                ),
              )
            : SelectableText(
                message.text.trimLeft(),
                cursorColor: PrimaryColor.chataiAccent,
                // textAlign: isUser ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  color: isUser
                      ? Colors.white
                      : isDarkTheme
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black,
                ),
              ),
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        height: controller.activateRecord.value ? 300 : 100,
        decoration: const BoxDecoration(
            color: PrimaryColor.color,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.activateRecord.value
                ? SizedBox(
                    width: width,
                    child: _buildRecordContainer(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                cursorColor: Colors.white.withOpacity(0.2),
                                style: const TextStyle(color: Colors.white),
                                controller: controller
                                    .messageTextEditingController.value,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                    //  contentPadding: const EdgeInsets.all(8),
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                    hintText: 'Type here...',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.send_outlined,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      onPressed: () {
                                        controller.onMessageSend();
                                      },
                                    )),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                inputFormatters: [
                                  NoLeadingSpaceFormatter(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            child: IconButton(
                              onPressed: () {
                                controller.onMessageSend(isImage: true);
                              },
                              icon: Icon(
                                Icons.image,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            child: IconButton(
                              onPressed: () {
                                controller.onActivateRecordEnabled(true);
                              },
                              icon: Icon(
                                Icons.mic_none_outlined,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: SizedBox(
                child: Obx(
                  () => Text(
                    controller.recordedText.value,
                    style: TextStyle(
                      color: controller.isRecording.value
                          ? Colors.white
                          : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  controller.stopListening();
                  controller.resetSpeechText();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
              Obx(
                () => AvatarGlow(
                  endRadius: 75.0,
                  animate: controller.isRecording.value,
                  duration: const Duration(milliseconds: 2000),
                  glowColor: PrimaryColor.color.shade400,
                  repeat: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  showTwoGlows: true,
                  child: CircleAvatar(
                    backgroundColor: PrimaryColor.color.shade400,
                    radius: 35,
                    child: GestureDetector(
                      onTap: () {
                        controller.isRecording.value
                            ? controller.onSpeechTextMessageSend()
                            : controller.startListening();
                      },
                      /* onTapDown: (TapDownDetails details) {
                          controller.startListening();
                        },
                        onTapUp: (TapUpDetails details) {
                          controller.stopListening();
                        },*/
                      child: Icon(
                        controller.isRecording.value
                            ? Icons.mic
                            : Icons.mic_none_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.onActivateRecordEnabled(false);
                },
                icon: Icon(
                  Icons.cancel,
                  color: PrimaryColor.color.shade400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimmedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection(
          baseOffset: trimmedText.length,
          extentOffset: trimmedText.length,
        ),
      );
    }

    return newValue;
  }
}
