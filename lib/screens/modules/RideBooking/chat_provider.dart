import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chat {
  String username;
  String message;
  String type;
  Chat({this.username = '', this.message = '', this.type = ''});
}

class ChatProvider with ChangeNotifier {
  List<Chat> chat = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshots;

  add(Chat c) {
    chat.add(c);
    notifyListeners();
  }

  attachSnapshot(Stream<QuerySnapshot<Map<String, dynamic>>> snap) {
    snapshots = snap;
    notifyListeners();
  }

  removeSnapshot() {
    snapshots?.listen((event) {}).cancel();
    snapshots = null;
    notifyListeners();
  }
}
