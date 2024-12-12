import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';

class Chatswindow extends StatelessWidget {
  const Chatswindow({super.key, this.chatState});

  final chatState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          if(index % 2 == 0){
            return leftChat();
          } else {
            return rightChat();
          }
        },
      ),
    );
  }

  Widget leftChat() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.network('https://picsum.photos/300/300',
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BubbleNormal(
                text:
                    'Show me other options aaaaaaaaaaaaaaaaaaaaaaaaaaa bbbbbbbbbbbbb',
                isSender: false,
                tail: false,
                color: Color(0xfff2f4f5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text('2024-12-10 15:00  Nickname'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget rightChat() {
    return Padding(
      padding: const EdgeInsets.only(right: 24, top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BubbleNormal(
                text:
                    'Show me other options aaaaaaaaaaaaaaaaaaaaaaaaaaa bbbbbbbbbbbbb',
                isSender: false,
                tail: false,
                color: Color(0xff0070f0),
                textStyle: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text('Nickname  2024-12-10 15:00'),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.network('https://picsum.photos/300/300',
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
