import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/chat_provider.dart';
import 'package:womanista/variables/variables.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Chat> staticChat = [
    Chat(message: "Hello", username: "demo", type: "user"),
    Chat(message: "hey", username: "demo 2", type: "driver"),
    Chat(message: "where are you?", username: "demo", type: "user"),
    Chat(message: "I am on my way!", username: "demo 2", type: "driver"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  attachsnapshot(ChatProvider provider) {
    provider.snapshots = FirebaseFirestore.instance
        .collection("Rides")
        .doc(widget.id)
        .collection("Chat")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var chatProvider = Provider.of<ChatProvider>(context);
    attachsnapshot(chatProvider);
    //chatProvider.chat = staticChat;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: Text(
          "Chat",
          style: AppSettings.textStyle(textColor: Colors.white),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.phone),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: buildChat(context, chatProvider, screenSize),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                      hintText: "When will you Arrive?",
                      hintStyle: AppSettings.textStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppSettings.mainColor,
                          )),
                      fillColor: AppSettings.mainColor,
                      focusColor: AppSettings.mainColor,
                      hoverColor: AppSettings.mainColor,
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    ),
                    style: AppSettings.textStyle(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (message.text != '') {
                    FirebaseFirestore.instance
                        .collection("Rides")
                        .doc(widget.id)
                        .collection("Chat")
                        .add({
                      'username': 'demo',
                      'type': AppSettings.isDriverMode ? "driver" : "user",
                      'message': message.text
                    });
                    // context.read<ChatProvider>().add(
                    //       Chat(
                    //           username: 'demo',
                    //           type: 'user',
                    //           message: message.text),
                    //     );
                    // _controller.animateTo(
                    //   _controller.position.maxScrollExtent,
                    //   duration: const Duration(milliseconds: 500),
                    //   curve: Curves.fastOutSlowIn,
                    // );
                    message.text = '';
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: AppSettings.mainColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget buildChat(
      BuildContext context, ChatProvider chatProvider, Size screenSize) {
    return chatProvider.snapshots == null
        ? const Center(
            child: Text("Snapshot is null"),
          )
        : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: chatProvider.snapshots,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppSettings.mainColor,
                    strokeWidth: 2,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Container(
                  child: Text("${snapshot.error}"),
                );
              }
              chatProvider.chat = [];
              log("${snapshot.data!.docs.length}");
              for (var element in snapshot.data!.docs) {
                var data = element.data();
                chatProvider.add(Chat(
                  type: data['type'],
                  message: data['message'],
                  username: data['username'],
                ));
              }
              return ListView.builder(
                controller: _controller,
                itemCount: chatProvider.chat.length,
                itemBuilder: (context, index) {
                  if (chatProvider.chat[index].type == "user") {
                    return Row(
                      mainAxisAlignment: AppSettings.isDriverMode
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: screenSize.width * 0.05,
                                maxWidth: screenSize.width * 0.8,
                              ),
                              child: Text(
                                chatProvider.chat[index].message,
                                style: AppSettings.textStyle(),
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: AppSettings.isDriverMode
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: screenSize.width * 0.05,
                                maxWidth: screenSize.width * 0.8,
                              ),
                              child: Text(
                                chatProvider.chat[index].message,
                                style: AppSettings.textStyle(),
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            });
  }
}
