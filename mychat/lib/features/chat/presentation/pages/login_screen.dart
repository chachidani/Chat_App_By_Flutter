import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/pages/home_screen.dart';
import 'package:mychat/features/chat/presentation/widget/button_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> listOfChats = [
    ChatModel(
      name: "John Doe",
      icon: "assets/images/user1.jpg",
      isGroup: false,
      time: "Now",
      currentMessage: "Hello there, how are you?",
      id: 1,
    ),
    ChatModel(
      name: "Dev Stack",
      icon: "assets/images/user2.jpg",
      isGroup: false,
      time: "2:30",
      currentMessage: "Hey, I am good",
      id: 2,
    ),
    ChatModel(
      name: "Jane node",
      icon: "assets/images/user2.jpg",
      isGroup: false,
      time: "2:30",
      currentMessage: "Hey, I am good",
      id: 3,
    ),
    ChatModel(
      name: "Coner ranam",
      icon: "assets/images/user2.jpg",
      isGroup: false,
      time: "2:30",
      currentMessage: "Hey, I am very good",
      id: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                sourceChat = listOfChats.removeAt(index);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(  sourceChat: sourceChat , chatModels: listOfChats)));
              },
              child: ButtonCard(
                  name: listOfChats[index].name, icon: Icons.person)),
          itemCount: listOfChats.length),
    );
  }
}
