import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 러닝 시작/러닝 종료 버튼 UI를 바꾸기 위해 bool값을 전달하는 뷰모델
class Button {
  bool isRunning = false;
  Button(this.isRunning);
}

class ButtonViewModel extends Notifier<Button> {
  @override
  build() {
    return Button(
      false,
    );
  }

  void startRunning() {
    state = Button(
      true,
    );
  }

  void stopRunning() {
    state = Button(
      false,
    );
  }
}

final buttonViewModel = NotifierProvider<ButtonViewModel, Button>(
  () => ButtonViewModel(),
);
