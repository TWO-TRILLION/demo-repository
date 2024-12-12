import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/model/chatmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/chatrepository.dart';

class PresenchatpageState{
  String location;
  Chatmodel chats;

  PresenchatpageState(this.location, this.chats);
}

class PresenchatpageViewmodel extends Notifier<PresenchatpageState>{
  @override
  PresenchatpageState build() {
    Chatmodel defaultChatmodel = Chatmodel(chatroomid: "", updatetime: DateTime.now(), member: [], chats: []);
    return PresenchatpageState('',defaultChatmodel);
  }

  // 채팅 지역 받아오는 메서드
  void setLocation(String location){
    state.location = location;
    // state = PresenchatpageState(location, state.chats);
  }

  // 현 지역 채팅 가져오는 메서드
  Future<void> readChats() async {
    final chatrepository = Chatrepository();
    final chats = await chatrepository.get(state.location);

    state = PresenchatpageState(state.location, chats[0]);
  }

  // 현 지역 채팅 실시간 가져오는 메서드
  void streamChats() {
    final chatrepository = Chatrepository();

    final stream = chatrepository.getStream(state.location);
    final streamSubscription = stream.listen((chats){
      state = PresenchatpageState(state.location, chats[0]);
    });
    ref.onDispose((){
      streamSubscription.cancel();
    });
  }
}

final PresenchatpageViewModelProvider = NotifierProvider<PresenchatpageViewmodel,PresenchatpageState>((){
  return PresenchatpageViewmodel();
});