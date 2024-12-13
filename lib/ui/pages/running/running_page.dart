import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            '${startTime.month}월 ${startTime.day}일 ${startTime.hour}시 ${startTime.minute}분',
            style: TextStyle(
              color: Color(0xff979C9E),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 300,
            height: 1,
            color: Color(0xff979C9E),
          ),
          SizedBox(height: 30),
          RunningAnalysis(
              startTime: startTime, startLat: startLat, startLng: startLng),
          KakaoMap(lat: startLat, lng: startLng),
        ],
      ),
    );
  }
}
