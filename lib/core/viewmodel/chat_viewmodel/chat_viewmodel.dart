import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/model/chatmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/chatrepository.dart';

class ChatState {
  String location;
  Chatmodel chats;

  ChatState(this.location, this.chats);
}

class ChatViewmodel extends Notifier<ChatState> {
  @override
  ChatState build() {
    Chatmodel defaultChatmodel = Chatmodel(
        chatroomid: "", updatetime: DateTime.now(), member: [], chats: []);
    return ChatState('', defaultChatmodel);
  }

  // 채팅 지역 받아오는 메서드
  void setLocation(String location) {
    state.location = location;
    // state = ChatState(location, state.chats);
  }

  // 현 지역 채팅 가져오는 메서드
  // 현 지역 채팅방이 없으면 생성후 다시 가져오기
  Future<void> readChats() async {
    final chatrepository = Chatrepository();
    try {
      final chats = await chatrepository.get(state.location);

      state = ChatState(state.location, chats[0]);
      streamChats();
    } catch (e) {
      newChatRoom();
      readChats();
    }
  }

  // 현 지역 채팅 실시간 가져오는 메서드
  void streamChats() {
    final chatrepository = Chatrepository();
    final stream = chatrepository.getStream(state.location);
    final streamSubscription = stream.listen((chats) {
      state = ChatState(state.location, chats[0]);
    });

    ref.onDispose(() {
      print('chatstream dispose');
      streamSubscription.cancel();
    });
  }

  // 새로운 채팅방 생성
  void newChatRoom() {
    final chatrepository = Chatrepository();

    Map<String,dynamic> defalutchat = {
      "createdAt": DateTime.now().toIso8601String(),
      "message": "시스템 : 채팅방이 생성되었습니다.",
      "userid": "systemMessagelog1234"
    };

    chatrepository.insert(
        chatroomid: state.location,
        updatetime: DateTime.now(),
        member: [],
        chats: [defalutchat]);
  }

  // 새로운 채팅 입력
  void newChat(String userid, String chat){
    final chatrepository = Chatrepository();

    chatrepository.update(state.location, userid, chat);
  }
}

final chatViewModelProvider = NotifierProvider<ChatViewmodel, ChatState>(() {
  return ChatViewmodel();
});
