import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/login/login_page.dart';

class JoinState {
  TextEditingController idController;
  TextEditingController pwController;
  TextEditingController nicknameController;

  JoinState(this.idController, this.pwController, this.nicknameController);
}

class JoinViewModel extends Notifier<JoinState> {
  @override
  JoinState build() {
    return JoinState(TextEditingController(), TextEditingController(),
        TextEditingController());
  }

  void onJoin(BuildContext context) async {
    final userRepo = UserRepository();
    String newId = state.idController.text;
    final isDuplicated = await userRepo.checkDuplicatedId(newId);
    if (isDuplicated) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              '중복된 아이디 입니다.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            content: Text('다른 아이디를 입력해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              )
            ],
          );
        },
      );
    } else {
      userRepo.insert(
        userid: state.idController.text,
        userpw: state.pwController.text,
        nickname: state.nicknameController.text,
        lastchatroomid: '',
        runningData: RunningData(distance: 0, calorie: 0, speed: 0),
        imageUrl: '',
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
        (route) {
          return false;
        },
      );
    }
  }
}

final joinViewModelProvider = NotifierProvider<JoinViewModel, JoinState>(
  () {
    return JoinViewModel();
  },
);
