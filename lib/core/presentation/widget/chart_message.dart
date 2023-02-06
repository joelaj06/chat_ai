import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:flutter/material.dart';
class ChatMessage extends StatelessWidget {
  const ChatMessage({
    required this.textMessage,
    this.sender,
    Key? key}) : super(key: key);


  final String textMessage;
  final String? sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: sender == null ? Colors.white54 : PrimaryColor.color,
          child: Text(sender?[0] ?? 'B',
          style: const TextStyle(
            color: Colors.white,
          ),),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white54,
          ),
          child: Text(textMessage),
        )
      ],
    );
  }
}
