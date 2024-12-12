import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';


class RunningPage extends StatelessWidget {
  const RunningPage({super.key});

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
            RunningInformation(title: '달린 거리', value: 0),
            RunningInformation(title: '평균 속력', value: 0),
            RunningInformation(title: '소모한 칼로리', value: 0),
            SizedBox(height: 30),
            KakaoMap(lat: 0, lng: 0)
          ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RunningAnalysis(
              startTime: startTime, startLat: startLat, startLng: startLng),
          KakaoMap(lat: startLat, lng: startLng),
        ],
    );
  }
}
