import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.chatState});

  final chatState;

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return Stack(
      children: [
        Container(
          color: Color(0xffffcf8b),
        ),
        Positioned(
          left: 30,
          top: 40,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Consumer(
                    builder: (context, ref, child) {
                      return FutureBuilder(
                        future: userRepository
                            .getOne(ref.read(userViewModelProvider)),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.imageUrl! != ''
                                ? Image.network(
                                    snapshot.data!.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'assets/images/default_profile.png'),
                                  )
                                : Image.asset(
                                    'assets/images/default_profile.png');
                          } else {
                            return Image.asset(
                                'assets/images/default_profile.png');
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatState.chats.chatroomid}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${chatState.chats.member.length} 명 참여 중',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
