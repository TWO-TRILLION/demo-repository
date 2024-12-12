import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';

class RunningPage extends StatelessWidget {
  RunningPage({required this.startLat, required this.startLng});

  double distance = 0;
  double speed = 0;
  double calorie = 0;
  DateTime? time;
  double startLat;
  double startLng;
  DateTime startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RunningInformation(title: '달린 거리', value: distance),
            RunningInformation(title: '평균 속력', value: speed),
            RunningInformation(title: '소모한 칼로리', value: calorie),
            SizedBox(height: 30),
            KakaoMap(lat: startLat, lng: startLng)
          ],
        ),
      ),
    );
  }
}
