import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/background.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/bottomwindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/fruit.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/hill.dart';

class Presenchatpage extends StatelessWidget {
  const Presenchatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            // 배경
            Background(),
            // 언덕
            Hill(),
            // 과일
            Fruit(),
            // 메뉴바
            Bottomwindow(),
          ],
        )),
    );
  }
}