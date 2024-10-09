import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';

class AvatorCard extends StatelessWidget {
  final ChatModel selectedmember;
  const AvatorCard({super.key , required this.selectedmember});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
      
        children: [
          Stack(
            children: [CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey.shade200,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
               Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 11,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 18,
                    )),
              ) 
            ],
          ),
          Text(
            selectedmember.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      
      ),
    );
  }
}