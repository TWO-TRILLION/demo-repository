import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sprinchat_app/core/validator_utils.dart';

class IdTextFormField extends StatelessWidget {
  const IdTextFormField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: "아이디"),
      validator: ValidatorUtils.validatorId,
      controller: controller,
      inputFormatters: [EnglishAndNumberTextInputFormatter()],
    );
  }
}

class EnglishAndNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regex = RegExp(r'^[a-zA-Z0-9]*$');
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (regex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
