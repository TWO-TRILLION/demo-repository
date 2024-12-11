import 'package:flutter/material.dart';

class Hill extends StatelessWidget {
  const Hill({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 350,
      left: 0,
      right: 0,
      child: ClipOval(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xffc7753b),
          ),
        ),
      ),
    );
  }
}