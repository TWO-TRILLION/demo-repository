import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

class Chatswindow extends StatelessWidget {
  const Chatswindow({super.key, this.chatState, this.scrollController});

  final chatState;
  final scrollController;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> orderchats = chatState.chats.chats;

    // 채팅 시간대 정렬
    orderchats.sort((a, b) => a['createdAt'].compareTo(b['createdAt']));

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: orderchats.length,
        itemBuilder: (context, index) {
          if (chatState.userid == orderchats[index]['userid']) {
            return rightChat(index, orderchats);
          } else if ("systemMessagelog1234" == orderchats[index]['userid']) {
            return systemChat(index, orderchats);
          } else {
            return leftChat(index, orderchats);
          }
        },
      ),
    );
  }

  Widget leftChat(int index, List<Map<String, dynamic>> orderchats) {
    bool isDiffUser = true;

    if (index > 0 && index < orderchats.length - 1) {
      if (orderchats[index]['userid'] == orderchats[index + 1]['userid']) {
        isDiffUser = false;
      }
    }

    DateTime date = DateTime.parse(orderchats[index]['createdAt']);
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String dateTime =
        '${date.year}-${date.month}-${date.day} ${date.hour} : $minute';

    final userRepository = UserRepository();

    return Padding(
      padding: EdgeInsets.only(left: 24, bottom: isDiffUser ? 30 : 0),
      child: FutureBuilder(
        future: userRepository.getOne(orderchats[index]['userid']),
        builder: (context, snapshot) {
          // 정상적으로 userNickname, userImageUrl 이 가져와졌을경우
          if (snapshot.hasData) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: isDiffUser
                      ? SizedBox(
                          width: 40,
                          height: 40,
                          child: snapshot.data!.imageUrl! != '' ? Image.network(
                            snapshot.data!.imageUrl!,
                            fit: BoxFit.cover,
                          ) : Image.asset('assets/images/default_profile.png'),
                        )
                      : SizedBox(
                          width: 40,
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BubbleSpecialThree(
                      text: orderchats[index]['message'],
                      isSender: false,
                      tail: true,
                      color: Color(0xfff2f4f5),
                    ),
                    if (isDiffUser)
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          '$dateTime  ${snapshot.data!.nickname}',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                  ],
                )
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: isDiffUser
                      ? SizedBox(
                          width: 40,
                          height: 40,
                          child:
                              Image.asset('assets/images/default_profile.png'),
                        )
                      : SizedBox(
                          width: 40,
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BubbleSpecialThree(
                      text: orderchats[index]['message'],
                      isSender: false,
                      tail: true,
                      color: Color(0xfff2f4f5),
                    ),
                    if (isDiffUser)
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          '$dateTime  Nickname',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget rightChat(int index, List<Map<String, dynamic>> orderchats) {
    bool isDiffUser = true;

    if (index > 0 && index < orderchats.length - 1) {
      if (orderchats[index]['userid'] == orderchats[index + 1]['userid']) {
        isDiffUser = false;
      }
    }

    DateTime date = DateTime.parse(orderchats[index]['createdAt']);
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String dateTime =
        '${date.year}-${date.month}-${date.day} ${date.hour} : $minute';

    final userRepository = UserRepository();

    return Padding(
      padding: EdgeInsets.only(right: 24, bottom: isDiffUser ? 30 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BubbleSpecialThree(
                text: orderchats[index]['message'],
                isSender: true,
                tail: true,
                color: Color(0xff0070f0),
                textStyle: TextStyle(color: Colors.white),
              ),
              if (isDiffUser)
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: FutureBuilder(
                    future: userRepository.getOne(orderchats[index]['userid']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data!.nickname}  $dateTime',
                          style: TextStyle(fontSize: 12),
                        );
                      } else {
                        return Text(
                          'Nickname  $dateTime',
                          style: TextStyle(fontSize: 12),
                        );
                      }
                    },
                  ),
                )
            ],
          ),
          /* 현 유저의 프로필사진은 띄울 필요 없다는 의견이 타당하다고 생각해서 지움
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: isDiffUser
                ? SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.network('https://picsum.photos/300/300',
                        fit: BoxFit.cover),
                  )
                : SizedBox(
                    width: 40,
                  ),
          ),
          */
        ],
      ),
    );
  }

  Widget systemChat(int index, List<Map<String, dynamic>> orderchats) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 30,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.purple.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              orderchats[index]['message'],
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
