import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:mychat/features/chat/data/models/message_model.dart';
import 'package:mychat/features/chat/presentation/widget/own_messege_card.dart';
import 'package:mychat/features/chat/presentation/widget/reply_message_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualchatScreen extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  const IndividualchatScreen(
      {super.key, required this.chatModel, required this.sourceChat});

  @override
  State<IndividualchatScreen> createState() => _IndividualchatScreenState();
}

class _IndividualchatScreenState extends State<IndividualchatScreen> {
  bool showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  late io.Socket socket;
  bool sendbutton = false;
  List<MessageModel> messages = [];

  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  void connect() {
    socket = io.io("http://172.20.10.13:5000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.emit("/login", widget.sourceChat.id);
    socket.onConnect((data) {
      print('object connected');
      socket.on("message", (msg) {
        print('this');
        print(msg);

        setMessage(MessageModel(
            id: 1,
            message: msg["message"],
            time: DateTime.now().toString(),
            type: 'destination'));

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage(MessageModel(
      id: 1,
      message: message,
      time: DateTime.now().toString(),
      type: 'source',
    ));
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(MessageModel messageModel) {
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/whatsup_background.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0,
          leadingWidth: 85,
          leading: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 0,
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                    child: Icon(
                      (widget.chatModel.isGroup ?? false)
                          ? Icons.group
                          : Icons.person,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: InkWell(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'last seen today at 12:05',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'View contact',
                    child: Text('View contact'),
                  ),
                  const PopupMenuItem(
                    value: 'Media, links, and docs',
                    child: Text('Media, links, and docs'),
                  ),
                  const PopupMenuItem(
                    value: 'Search',
                    child: Text('Search'),
                  ),
                  const PopupMenuItem(
                    value: 'Mute notifications',
                    child: Text('Mute notifications'),
                  ),
                  const PopupMenuItem(
                    value: 'Wallpaper',
                    child: Text('Wallpaper'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return const SizedBox(
                            height: 200,
                          );
                        }
                        if (messages[index].type == 'source') {
                          return OwnMessegeCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                        // return  ListTile(
                        //   title: Column(
                        //     children: [ReplyMessageCard(), OwnMessegeCard()],
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _textController,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      sendbutton = true;
                                    });
                                  } else {
                                    setState(() {
                                      sendbutton = false;
                                    });
                                  }
                                },
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type a message',
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.emoji_emotions),
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        showEmojiPicker = !showEmojiPicker;
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.attach_file),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomsheet(context));
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.camera_alt),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/camera');
                                        },
                                      ),
                                    ],
                                  ),
                                  contentPadding: const EdgeInsets.all(5),
                                ),
                              ),
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 8, right: 5, left: 2),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 25,
                            child: IconButton(
                              icon: Icon(
                                sendbutton ? Icons.send : Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (sendbutton) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                  sendMessage(
                                      _textController.text,
                                      widget.sourceChat.id,
                                      widget.chatModel.id);
                                  _textController.clear();
                                  setState(() {
                                    sendbutton = false;
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    if (showEmojiPicker) emojiPicker(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

Widget bottomsheet(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 278,
    child: Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.insert_drive_file, 'Document', Colors.blue),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.camera_alt, 'Camera', Colors.pink),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.insert_photo, 'Gallery', Colors.purple),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.headset, 'Auido', Colors.orange),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.location_pin, 'Location', Colors.pink),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.person, 'Contact', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconcreation(IconData icon, String text, Color color) {
  return InkWell(
    onTap: () {},
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            color: Colors.white,
            size: 29,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ],
    ),
  );
}

Widget emojiPicker(BuildContext context) {
  return EmojiPicker(
    config: Config(
      height: 256,
      checkPlatformCompatibility: true,
      emojiViewConfig: EmojiViewConfig(
        // Issue: https://github.com/flutter/flutter/issues/28894
        emojiSizeMax: 28 *
            (foundation.defaultTargetPlatform == TargetPlatform.iOS
                ? 1.2
                : 1.0),
      ),
      skinToneConfig: const SkinToneConfig(),
      categoryViewConfig: const CategoryViewConfig(),
      bottomActionBarConfig: const BottomActionBarConfig(),
      searchViewConfig: const SearchViewConfig(),
    ),
  );
}
