import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
