import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.chatState});

  final chatState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xffffcf8b),
        ),
        Positioned(
          left: 40,
          top: 40,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network('https://picsum.photos/300/300',fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatState.chats.chatroomid}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${chatState.chats.member.length} 명 참여 중',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}