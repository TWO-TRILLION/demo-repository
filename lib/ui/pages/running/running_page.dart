import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class RunningPage extends StatelessWidget {
  RunningPage({required this.lat, required this.lng});

  double distance = 0;
  double speed = 0;
  double calorie = 0;
  double lat;
  double lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RunningInformation(title: '달린 거리', value: distance),
            RunningInformation(title: '평균 속력', value: speed),
            RunningInformation(title: '소모한 칼로리', value: calorie),
            KakaoMapView(
              width: double.infinity,
              height: 400,
              kakaoMapKey: '08eebe69029ef27e6209ec2d97b79d29',
              lat: lat,
              lng: lng,
            )
          ],
        ),
      ),
    );
  }
}
