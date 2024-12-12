/*
{
  "chatroomid" : 
}
*/

class Chatmodel {
  String chatroomid;
  DateTime updatetime;
  List<Map<String,dynamic>> chats;

  Chatmodel({
    required this.chatroomid,
    required this.updatetime,
    required this.chats
  });

  Chatmodel.fromJson(Map<String,dynamic> json) : this(
    chatroomid: json['chatroomid'],
    updatetime: DateTime.parse(json['updatetime']),
    chats: (json['chats'] as List).map((item) => item as Map<String,dynamic>).toList()
  );

  Map<String,dynamic> toJson(){
    return {
      "chatroomid" : chatroomid,
      "updatetime" : updatetime.toIso8601String(),
      "chats" : chats,
    };
  }
}