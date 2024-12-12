import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/theme.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: LoginPage(),
    );
  }
}

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
    if (formKey.currentState?.validate() ?? false) {
      // 나중에 여기서 뷰모델 연동
    }
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
                      onPressed: () {},
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
