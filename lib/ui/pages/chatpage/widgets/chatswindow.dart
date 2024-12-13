import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class Chatswindow extends StatelessWidget {
  const Chatswindow({super.key, this.chatState});

  final chatState;

  @override
  Widget build(BuildContext context) {
    String userid = 'ABCD';

    return Expanded(
      child: ListView.builder(
        itemCount: chatState.chats.chats.length ?? 0,
        itemBuilder: (context, index) {
          if (userid == chatState.chats.chats[index]['userid']) {
            return rightChat(index);
          } else if ("systemMessagelog1234" ==
              chatState.chats.chats[index]['userid']) {
            return systemChat(index);
          } else {
            return leftChat(index);
          }
        },
      ),
    );
  }

  Widget leftChat(int index) {
    bool dateText = true;

    DateTime date = DateTime.parse(chatState.chats.chats[index]['createdAt']);
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String dateTime =
        '${date.year}-${date.month}-${date.day} ${date.hour} : $minute';

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
                text: chatState.chats.chats[index]['message'],
                isSender: false,
                tail: false,
                color: Color(0xfff2f4f5),
              ),
              if (dateText)
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text('$dateTime  Nickname'),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget rightChat(int index) {
    bool dateText = true;

    DateTime date = DateTime.parse(chatState.chats.chats[index]['createdAt']);
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String dateTime =
        '${date.year}-${date.month}-${date.day} ${date.hour} : $minute';

    return Padding(
      padding: const EdgeInsets.only(right: 24, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BubbleNormal(
                text: chatState.chats.chats[index]['message'],
                isSender: false,
                tail: false,
                color: Color(0xff0070f0),
                textStyle: TextStyle(color: Colors.white),
              ),
              if (dateText)
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text('Nickname  $dateTime'),
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

  Widget systemChat(int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 7,
          bottom: 7,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.purple.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              chatState.chats.chats[index]['message'],
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
