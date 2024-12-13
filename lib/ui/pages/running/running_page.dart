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
              SizedBox(
                height: 350,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    KakaoMap(lat: startLat, lng: startLng),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xff0070F0),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print('object');
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
