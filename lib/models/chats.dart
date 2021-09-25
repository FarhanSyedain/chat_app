enum MessageStatus { sent, recieved, read }
enum Sender { me, notMe }
enum ReceivedMessageStatus { read, unread }

class User {}

class Message {
  Map<String, dynamic>? get listTileDetails => {'': ''};
}

class Messages {
  List<Message>? _messages = [];
  Message? get lastMessage => _messages!.last;
}

class Chat {
  User? user;
  Messages? _messages;
  Messages? get messages => _messages;
}

class Chats {
  List<Chat>? _chat = [];

  List<Map<String, dynamic>?>? getChatListTiles() {
    List<Map<String, dynamic>?>? toBeReturned = [];

    for (var i = 0; i < _chat!.length; i++) {
      var lastMessage = _chat![i].messages!.lastMessage;
      toBeReturned.add(lastMessage!.listTileDetails);
    }
    return toBeReturned;
  }
}

//Firebase database would look like this.
class ChatUsers {
  User? user;
}
