import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/background.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/bottomwindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/fruit.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/hill.dart';

class PresenChatPage extends StatelessWidget {
  const PresenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    int membersNum = 8;

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
  }
}
