import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sprinchat_app/core/validator_utils.dart';

class NicknameTextFormField extends StatelessWidget {
  const NicknameTextFormField(
      {super.key, required this.controller, required TextAlign textAlign});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: "닉네임"),
      validator: ValidatorUtils.validatorNickname,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zㄱ-힣0-9]")),
        LengthLimitingTextInputFormatter(10), // 최대 10자 입력으로 제한
      ],
    );
  }
}
