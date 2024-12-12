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

  // 현 지역 채팅 가져오는 메서드
  Future<void> readChats() async {
    final chatrepository = Chatrepository();
    final chats = await chatrepository.get(state.location);

    state = PresenchatpageState(state.location, chats[0]);
  }
}

final PresenchatpageViewModelProvider = NotifierProvider<PresenchatpageViewmodel,PresenchatpageState>((){
  return PresenchatpageViewmodel();
});