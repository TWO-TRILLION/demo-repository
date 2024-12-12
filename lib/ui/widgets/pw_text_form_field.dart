import 'package:flutter/material.dart';
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
    );
  }
}
