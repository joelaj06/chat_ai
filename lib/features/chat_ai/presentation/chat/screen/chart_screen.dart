import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:chat_ai/core/presentation/widget/chart_message.dart';
import 'package:chat_ai/features/chat_ai/presentation/chat/getx/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    backgroundImage: AssetImage('assets/images/chat_gpt_logo.png'),
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
                        Obx(() => Text(
                            controller.isLoading.value ? 'typing' : 'Online',
                            style: TextStyle(
                                fontStyle: controller.isLoading.value ? FontStyle.italic : FontStyle.normal,
                                color: Colors.grey.shade600, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: <Widget>[
            Flexible(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildChatListTile(
                        context, controller.chatMessages[index]),
                  ),
                ),
              ),
            ),
            _buildTextComposer(),
          ],
        ));
  }

  Widget _buildChatListTile(BuildContext context, ChatMessage message) {
    final bool isUser = message.sender == Sender.user.name;

    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          // width: width * 0.85,
          decoration: BoxDecoration(
              color: isUser
                  ? PrimaryColor.color.shade500
                  : Colors.grey.shade300.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: isUser ? const Radius.circular(10) : Radius.zero,
                topRight: isUser ? Radius.zero : const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.textMessage.trimLeft(),
              // textAlign: isUser ? TextAlign.end : TextAlign.start,
              style: TextStyle(color: isUser ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: PrimaryColor.color,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      cursorColor: Colors.white.withOpacity(0.2),
                      style: const TextStyle(color: Colors.white),
                      controller: controller.messageTextEditingController.value,
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
                    ),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mic_none_outlined,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
