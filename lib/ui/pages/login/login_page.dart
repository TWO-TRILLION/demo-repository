import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/join_page.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void onLoginClick() async {
    final userRepo = UserRepository();

    final user = await userRepo.getOne(idController.text);

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
    } else if (user.userpw != pwController.text) {
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
    } else
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
      );

    ;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    SizedBox(height: 40),
                    IdTextFormField(controller: idController),
                    SizedBox(height: 30),
                    PwTextFormField(controller: pwController),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: (onLoginClick), child: Text('로그인')),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return JoinPage();
                          },
                        ));
                      },
                      child: Text('회원가입'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
