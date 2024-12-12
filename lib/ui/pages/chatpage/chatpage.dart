import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/widgets/chatswindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/widgets/inputmessage.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: Column(
          children: [
            // 채팅창
            Chatswindow(),
            // 입력필드
            Inputmessage(),
          ],
        )),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentPage: 'chat'),
    );
  }
}
