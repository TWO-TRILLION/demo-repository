import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
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

  void onImageUpload() {}

  void onJoin() async {
    final userRepo = UserRepository();
    String newId = idController.text;
    bool isDuplicated = await userRepo.checkDuplicatedId(newId);
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
        userid: idController.text,
        userpw: pwController.text,
        nickname: nicknameController.text,
        lastchatroomid: '',
        runningData: RunningData(distance: 0, kcal: 0, speed: 0),
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
                    GestureDetector(
                      onTap: onImageUpload,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
