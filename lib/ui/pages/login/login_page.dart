import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/join_page.dart';
import 'package:flutter_sprinchat_app/ui/pages/login/login_view_model.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
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
                    IdTextFormField(controller: loginState.idController),
                    SizedBox(height: 30),
                    PwTextFormField(controller: loginState.pwController),
                    SizedBox(height: 30),
                    Consumer(
                      builder: (context, ref, child) => ElevatedButton(
                          onPressed: () {
                            ref
                                .watch(loginViewModelProvider.notifier)
                                .onLoginClick(context);
                          },
                          child: Text('로그인')),
                    ),
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
