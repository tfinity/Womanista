import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/chat_provider.dart';
import 'package:womanista/variables/variables.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var chatProvider = Provider.of<ChatProvider>(context);
    chatProvider.chat = staticChat;
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
                    context.read<ChatProvider>().add(
                          Chat(
                              username: 'demo',
                              type: 'user',
                              message: message.text),
                        );
                    _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
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

  Widget buildChat(
      BuildContext context, ChatProvider chatProvider, Size screenSize) {
    return ListView.builder(
      controller: _controller,
      itemCount: chatProvider.chat.length,
      itemBuilder: (context, index) {
        if (chatProvider.chat[index].type == "user") {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
  }
}
