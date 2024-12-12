import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/viewmodel/presenchatpage_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/background.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/bottomwindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/fruit.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/hill.dart';

class Presenchatpage extends ConsumerStatefulWidget {
  const Presenchatpage({super.key});

  @override
  ConsumerState<Presenchatpage> createState() => _PresenchatpageState();
}

class _PresenchatpageState extends ConsumerState<Presenchatpage> {
  @override
  void initState() {
    ref.read(PresenchatpageViewModelProvider.notifier).streamChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var presenchatpageState = ref.watch(PresenchatpageViewModelProvider);
    int membersNum = presenchatpageState.chats.member.length;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 배경
          Background(membersNum: membersNum),
          // 언덕
          Hill(),
          // 과일
          Fruit(membersNum: membersNum),
          // 메뉴바
          Bottomwindow(),
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
    ;
  }
}
