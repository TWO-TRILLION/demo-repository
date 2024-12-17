import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void onJoin() async {}
}

final joinViewModelProvider = NotifierProvider<JoinViewModel, JoinState>(
  () {
    return JoinViewModel();
  },
);
