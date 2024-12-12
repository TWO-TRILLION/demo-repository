import 'package:flutter/material.dart';

class Hill extends StatelessWidget {
  const Hill({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height/2 - 120,
      left: -170,
      child: ClipOval(
        child: Container(
          width: 800,
          height: 400,
          decoration: BoxDecoration(
            color: Color(0xffc7753b),
          ),
        ),
      ),
    );
  }
}