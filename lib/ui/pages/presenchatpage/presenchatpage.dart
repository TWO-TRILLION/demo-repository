import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/background.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/bottomwindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/fruit.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/hill.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

class Presenchatpage extends ConsumerStatefulWidget {
  const Presenchatpage({super.key});

  @override
  ConsumerState<Presenchatpage> createState() => _PresenchatpageState();
}

class _PresenchatpageState extends ConsumerState<Presenchatpage> {
  @override
  void initState() {
    super.initState();
    final location = ref.read(locationViewModelProvider);
    final userid = ref.read(userViewModelProvider);
    // 위치세팅(chatroomid)
    ref.read(chatViewModelProvider.notifier).setLocation(location);
    // 유저세팅(userid)
    ref.read(chatViewModelProvider.notifier).setUserId(userid);

    // db읽고(채팅방 없으면 만들고), 스트림 세팅
    ref.read(chatViewModelProvider.notifier).readChats();
  }

  @override
  Widget build(BuildContext context) {
    // final location = ref.watch(locationViewModelProvider);
    var chatState = ref.watch(chatViewModelProvider);
    int membersNum = chatState.chats.member.length;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 배경
          Background(chatState: chatState),
          // 언덕
          Hill(),
          Fruit(membersNum: membersNum),
          Bottomwindow(),
        ],
      )),
      bottomNavigationBar: CustomNavigationBar(currentPage: 'chat'),
    );
  }
}
