import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/join_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/join/widgets/first_profile_image.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class JoinPage extends ConsumerStatefulWidget {
  JoinPage();

  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final joinState = ref.watch(joinViewModelProvider);
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
                    IdTextFormField(controller: joinState.idController),
                    SizedBox(height: 20),
                    PwTextFormField(controller: joinState.pwController),
                    SizedBox(height: 20),
                    NicknameTextFormField(
                      controller: joinState.nicknameController,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          final bool isValid =
                              formKey.currentState!.validate() ?? false;
                          if (!isValid) {
                            return;
                          }
                          ref
                              .watch(joinViewModelProvider.notifier)
                              .onJoin(context);
                        },
                        child: Text('가입하기')),
                    SizedBox(height: 50)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
