import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/pages/individualchat_screen.dart';

class Customchatcard extends StatelessWidget {
  final ChatModel Chats;
  final ChatModel sourceChat;
  const Customchatcard({super.key , required this.Chats , required this.sourceChat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualchatScreen( chatModel: Chats, sourceChat: sourceChat,)));
      },
      child: Column(
        children: [
          ListTile(
            leading:  CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 30,
              child: Icon((Chats.isGroup ?? false) ? Icons.group : Icons.person , color: Colors.white, ),
              
              
            ),
            title: Text( Chats.name ,style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
            subtitle:  Row(
              children: [
                const Icon(Icons.done_all),
                 const SizedBox(width: 3,),
                Text(Chats.currentMessage ?? '', style: const TextStyle(fontSize: 13),),
          
              ],
            ),
            trailing:  Text(Chats.time ?? '' , style: const TextStyle(fontSize: 13),),
          ),
        ],
      ),
    );
  }
}
