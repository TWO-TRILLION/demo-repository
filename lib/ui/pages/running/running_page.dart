import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';

class RunningPage extends StatelessWidget {
  double distance = 0;
  double speed = 0;
  double calorie = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RunningInformation(title: '달린 거리', value: distance),
          RunningInformation(title: '평균 속력', value: speed),
          RunningInformation(title: '소모한 칼로리', value: calorie),
        ],
      ),
    );
  }
}
