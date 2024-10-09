import 'package:flutter/material.dart';
import 'package:mychat/core/dummy/listofcontacts.dart';
import 'package:mychat/core/dummy/listofgroups.dart';
import 'package:mychat/features/chat/presentation/widget/avator_card.dart';
import 'package:mychat/features/chat/presentation/widget/contact_card.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'New Group',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              'Add participants',
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        Column(
          children:[ 
            groups.length > 0 ? SizedBox(height: 75) : Container(),
            Expanded(
              child: ListView.builder(
              itemCount: listOfcontacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (listOfcontacts[index].select == false) {
                        setState(() {
                          listOfcontacts[index].select = true;
                          groups.add(listOfcontacts[index]);
                        });
                      } else {
                        setState(() {
                          listOfcontacts[index].select = false;
                          groups.remove(listOfcontacts[index]);
                        });
                      }
                    },
                    child: ContactCard(contact: listOfcontacts[index]));
              },
                        ),
            ),]
        ),
       groups.length > 0 ? Column(
          children: [
            Container(
              height: 75,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          groups[index].select = false;
                          groups.remove(groups[index]);
                        });
                      },
                    child: AvatorCard(selectedmember: groups[index]));
                },
              ),
              
            ),
            Divider(
              thickness: 1,
            ),
            
          ],
        ) : Container()
      ]),
    );
  }
}
