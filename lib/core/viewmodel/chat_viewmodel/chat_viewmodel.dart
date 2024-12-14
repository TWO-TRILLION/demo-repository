import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/model/chatmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/chatrepository.dart';

// presenchatpage 하고, chatpage 에 영향을 주고 있는 State
// location이 채팅방에 chatroomid 역할을 맡음
class ChatState {
  String location;
  String userid;
  Chatmodel chats;
  ScrollController scrollController;

  ChatState(this.location, this.userid, this.chats, this.scrollController);
}

class ChatViewmodel extends AutoDisposeNotifier<ChatState> {
  @override
  ChatState build() {
    Chatmodel defaultChatmodel = Chatmodel(
        chatroomid: "", updatetime: DateTime.now(), member: [], chats: []);
    return ChatState('', '', defaultChatmodel, ScrollController());
  }

  // 유저 id, State에 받아오는 메서드
  void setUserId(String userid) {
    state.userid = userid;
  }

  // 채팅 지역, State에 받아오는 메서드
  void setLocation(String location) {
    state.location = location;
  }

  // 현 지역 채팅 가져오는 메서드
  // 현 지역 채팅방이 없으면 생성후 다시 가져오기
  Future<void> readChats() async {
    final chatrepository = Chatrepository();
    try {
      final chats = await chatrepository.get(state.location);

      state = ChatState(
          state.location, state.userid, chats[0], state.scrollController);
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
      state = ChatState(
          state.location, state.userid, chats[0], state.scrollController);
    });

    ref.onDispose(() {
      print('chatstream dispose');
      streamSubscription.cancel();
    });
  }

  // 새로운 채팅방 생성
  void newChatRoom() {
    final chatrepository = Chatrepository();

    Map<String, dynamic> defalutchat = {
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
  // 채팅방 멤버 안에 없으면 멤버리스트에도 유저id 추가
  // 유저가 채팅을 치면, 스크롤 컨트롤러가 마지막으로 가도록 설정
  void newChat(String chat) {
    final chatrepository = Chatrepository();
    chatrepository.update(state.location, state.userid, chat).then((_){
      scrollEndPosition();
    });
  }

  // 채팅방 참여 메서드 (해당 채팅방의 멤버리스트에 유저id 추가)
  // 유저가 다른 채팅방을 입장하게 될 경우 호출
  void newMember() {
    final chatrepository = Chatrepository();
    chatrepository.updateMember(state.location, state.userid);
  }

  // 채팅방 나가기 메서드 (해당 채팅방의 멤버리스트에서 유저id 제거)
  // 유저가 다른 채팅방을 입장하게 될 경우 호출
  void deleteMember() {
    final chatrepository = Chatrepository();
    chatrepository.deleteMember(state.location, state.userid);
  }

  // 스크롤 컨트롤러를 마지막으로 옮기는 메서드
  void scrollEndPosition() {
    state.scrollController
        .jumpTo(state.scrollController.position.maxScrollExtent);
  }
}

final chatViewModelProvider =
    AutoDisposeNotifierProvider<ChatViewmodel, ChatState>(() {
  return ChatViewmodel();
});
