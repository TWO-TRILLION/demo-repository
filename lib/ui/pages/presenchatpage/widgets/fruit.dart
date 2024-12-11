import 'package:flutter/material.dart';

class Fruit extends StatelessWidget {
  const Fruit({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height/2 - 200,
      left: MediaQuery.of(context).size.width/2 - 50,
      child: Image.asset('assets/fruits/strawberry.png')
    );
  }
}
