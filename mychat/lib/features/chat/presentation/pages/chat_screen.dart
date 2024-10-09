import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/widget/customchatcard.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel sourceChat;
  final List<ChatModel> chatModels;
  const ChatScreen({super.key , required this.sourceChat, required this.chatModels});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context , '/selectcontact');

        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (context, index) {
          return Customchatcard(Chats: widget.chatModels[index] , sourceChat: widget.sourceChat,);
        },
      ),
    );
  }
}
