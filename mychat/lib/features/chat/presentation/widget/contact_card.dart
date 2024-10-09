import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;
  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child:  Stack(
          children:[ CircleAvatar(
            radius: 23,
            backgroundColor: Colors.blueGrey.shade200,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
            
         contact.select ?  const Positioned(
              bottom: 4,
              right: 5,
              child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )),
            ):  Container()
            ]
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact.status ?? 'No status available',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
