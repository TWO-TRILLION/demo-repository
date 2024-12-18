import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
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
          height: MediaQuery.of(context).size.height / 2 - 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        final userRepo = UserRepository();
                        final user = await userRepo
                            .getOne(ref.read(userViewModelProvider));
                        String lastlocation = user!.lastchatroomid!;

                        if (lastlocation !=
                            ref.read(locationViewModelProvider)) {
                          ref
                              .read(chatViewModelProvider.notifier)
                              .deleteMember(lastlocation);
                        }
                        ref.read(chatViewModelProvider.notifier).newMember();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chatpage(null)));
                      },
                      child: Center(child: Text('참여하기')),
                    );
                  },
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
