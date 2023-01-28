import 'package:flutter/cupertino.dart';

class Chat {
  String username;
  String message;
  String type;
  Chat({this.username = '', this.message = '', this.type = ''});
}

class ChatProvider with ChangeNotifier {
  List<Chat> chat = [];

  add(Chat c) {
    chat.add(c);
    notifyListeners();
  }
}
