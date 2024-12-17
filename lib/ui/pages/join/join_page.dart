import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/join_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/widgets/first_profile_image.dart';
import 'package:flutter_sprinchat_app/ui/pages/login/login_page.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class JoinPage extends StatefulWidget {
  JoinPage();

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final JoinViewModel joinViewModel = JoinViewModel(UserRepository());
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final nicknameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nicknameController.dispose();
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void onJoin() async {
    final id = idController.text;
    final pw = pwController.text;
    final nickname = nicknameController.text;

    if (formKey.currentState!.validate()) {
      final isDuplicated = await joinViewModel.checkDuplicatedId(id);
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
        joinViewModel.createUser(id, pw, nickname);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Join'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FirstProfileImage(),
                    SizedBox(height: 40),
                    IdTextFormField(controller: idController),
                    SizedBox(height: 20),
                    PwTextFormField(controller: pwController),
                    SizedBox(height: 20),
                    NicknameTextFormField(controller: nicknameController),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: onJoin, child: Text('가입하기')),
                    SizedBox(height: 50)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
