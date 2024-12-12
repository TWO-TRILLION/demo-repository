import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/chatpage.dart';

class Bottomwindow extends StatelessWidget {
  const Bottomwindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height/2 - 200,
        decoration: BoxDecoration(
          color: Color(0xfff2f8ff),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Chatpage()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text('참여하기'),
            ),
            ),
        )
        ),
    );
  }
}