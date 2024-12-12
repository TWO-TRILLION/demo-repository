import 'package:flutter/material.dart';

class Fruit extends StatefulWidget {
  const Fruit({super.key, this.membersNum});

  final membersNum;

  @override
  State<Fruit> createState() => _FruitState();
}

class _FruitState extends State<Fruit> with TickerProviderStateMixin {
  late final AnimationController fruitAnimationController;
  late final Animation<Offset> _offset;
  late final CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    fruitAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    curve =
        CurvedAnimation(parent: fruitAnimationController, curve: Curves.linear);
    _offset = Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero)
        .animate(curve);

    fruitAnimationController.forward();

    fruitAnimationController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        fruitAnimationController.reverse();
      } else if (state == AnimationStatus.dismissed) {
        fruitAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    fruitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 0 ~ 9 : 딸기, 10 ~ 49 : 사과, 50 ~ 99 : 바나나, 100 ~ 999 : 수박, 1000 ~ : 귤
    List<String> fruits = ['strawberry.png','apple.png','banana.png','watermellon.png','mandarin.png'];

    String assetImage = 'assets/fruits/';
    if(widget.membersNum < 10){
      assetImage += fruits[0];
    } else if(widget.membersNum >= 10 && widget.membersNum < 50){
      assetImage += fruits[1];
    } else if(widget.membersNum >= 50 && widget.membersNum < 100){
      assetImage += fruits[2];
    } else if(widget.membersNum >= 100 && widget.membersNum < 1000){
      assetImage += fruits[3];
    } else {
      assetImage += fruits[4];
    }

    return Positioned(
        top: MediaQuery.of(context).size.height / 2 - 200,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: SlideTransition(
            position: _offset,
            child: Image.asset('assets/fruits/strawberry.png')));
  }
}
