import 'package:flutter/material.dart';
import 'package:mychat/core/dummy/listofcontacts.dart';
import 'package:mychat/features/chat/presentation/widget/button_card.dart';
import 'package:mychat/features/chat/presentation/widget/contact_card.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              '256 Contacts',
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Invite a friend',
                  child: Text('Invite a friend'),
                ),
                const PopupMenuItem(
                  value: 'Contacts',
                  child: Text('Contacts'),
                ),
                const PopupMenuItem(
                  value: 'Refresh',
                  child: Text('Refresh'),
                ),
                const PopupMenuItem(
                  value: 'Help',
                  child: Text('Help'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listOfcontacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newgroup');

              },
              child: ButtonCard(icon: Icons.group, name: 'New Group',));
          }else if (index == 1) {
            return ButtonCard(name: 'New Contact', icon: Icons.person_add,);
          }
          return ContactCard(contact: listOfcontacts[index-2]);
        },
      ),
    );
  }
}
