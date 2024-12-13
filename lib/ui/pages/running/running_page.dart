import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '러닝',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '${DateTime.now().month}월 ${DateTime.now().day}일 ${DateTime.now().hour}시 ${DateTime.now().minute}분',
                    style: TextStyle(
                      color: Color(0xff979C9E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              KakaoMap(lat: startLat, lng: startLng),
              SizedBox(height: 30),
              RunningAnalysis(
                  startTime: startTime, startLat: startLat, startLng: startLng),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentPage: 'running'),
    );
  }
}
