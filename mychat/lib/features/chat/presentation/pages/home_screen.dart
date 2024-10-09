import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/pages/calls_screen.dart';
import 'package:mychat/features/chat/presentation/pages/camera_screen.dart';
import 'package:mychat/features/chat/presentation/pages/chat_screen.dart';
import 'package:mychat/features/chat/presentation/pages/status_screen.dart';

class HomeScreen extends StatefulWidget {
  final ChatModel sourceChat;
   final List<ChatModel> chatModels;
  const HomeScreen({super.key, required this.sourceChat, required this.chatModels});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Chat',
          style: TextStyle(color: Colors.white),
        ),
        // background primary color
        backgroundColor: Theme.of(context).primaryColor,

        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // showSearch(context: context, delegate: DataSearch());
            },
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text('New group'),
                value: 'New group',
              ),
              const PopupMenuItem(
                child: Text('New broadcast'),
                value: 'New broadcast',
              ),
              const PopupMenuItem(
                child: Text('ChatApp Web'),
                value: 'ChatApp Web',
              ),
              const PopupMenuItem(
                child: Text('Starred messages'),
                value: 'Starred messages',
              ),
              const PopupMenuItem(
                child: Text('Settings'),
                value: 'Settings',
              ),
            ];
          }),
          // IconButton(
          //   icon: const Icon(Icons.more_vert , color: Colors.white),
          //   onPressed: () {
          //     // showSearch(context: context, delegate: DataSearch());
          //   },
          // ),
        ],
        // bottomnavigation bar with tab controller on tab bar
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.camera_alt,
              ),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        //inital index of tab controller to be 1

        controller: _tabController,
        children:  [
          CameraScreen(),
          ChatScreen( 
            sourceChat: widget.sourceChat,
            chatModels: widget.chatModels,
          ),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
    );
  }
}
