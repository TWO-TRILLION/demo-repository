import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/constant/colors.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginState {
  TextEditingController idController;
  TextEditingController pwController;

  LoginState(
    this.idController,
    this.pwController,
  );
}

class LoginViewModel extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(
      TextEditingController(),
      TextEditingController(),
    );
  }

  void onLoginClick(BuildContext context) async {
    final userRepo = UserRepository();

    final user = await userRepo.getOne(state.idController.text);

    if (user == null) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('로그인 오류'),
            content: Text('아이디를 확인하세요.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인'))
            ],
          );
        },
      );
    } else if (user.userpw != state.pwController.text) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('로그인 오류'),
            content: Text('비밀번호를 확인하세요.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인'))
            ],
          );
        },
      );
    } else {
      ref
          .read(userViewModelProvider.notifier)
          .setUserId(state.idController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHome(),
        ),
      );
      Fluttertoast.showToast(
          msg: '로그인 성공',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.blueAccent,
          textColor: Colors.white,
          fontSize: 16);
    }
  }
}

final loginViewModelProvider =
    AutoDisposeNotifierProvider<LoginViewModel, LoginState>(
  () {
    return LoginViewModel();
  },
);
