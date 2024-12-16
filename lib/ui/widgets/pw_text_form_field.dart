import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sprinchat_app/core/validator_utils.dart';

class PwTextFormField extends StatelessWidget {
  const PwTextFormField({super.key, required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(hintText: "비밀번호"),
      validator: ValidatorUtils.validatorPassword,
      controller: controller,
      inputFormatters: [AlphanumericAndSpecialTextInputFormatter()],
    );
  }
}

class AlphanumericAndSpecialTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regex = RegExp(r'^[a-zA-Z0-9\W]*$'); // \W는 모든 특수문자를 의미
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (regex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
