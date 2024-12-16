import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';

class RunningState {
  double distance; // 달린 거리
  double speed; // 평균 속력
  double calorie; // 소모한 칼로리
  int hour; // 달린 시간(시)
  int minute; // 달린 시간(분)
  int second;

  RunningState(
    this.distance,
    this.speed,
    this.calorie,
    this.hour,
    this.minute,
    this.second,
  );
}

class RunningViewModel extends Notifier<RunningState> {
  @override
  build() {
    return RunningState(0, 0, 0, 0, 0, 0);
  }

  double startLat = 0;
  double startLng = 0;
  late Timer timer;

  // 러닝 시작할 때 시작 위치 좌표 설정하는 함수
  Future<void> setLocation() async {
    final startLocation = await GeolocatorHelper.getPosition();
    if (startLocation != null) {
      startLat = startLocation.latitude;
      startLng = startLocation.longitude;
    }
  }

  // 초마다 러닝 정보를 계산해서 업데이트하는 함수
  Future<void> startRunning(
    DateTime startTime,
  ) async {
    timer = Timer.periodic(Duration(seconds: 1), (t) async {
      final currentLocation = await GeolocatorHelper.getPosition(); // 현재 위치 좌표
      var time = DateTime.now().difference(startTime); // 달린 시간

      double distance = 0;
      double speed = 0;
      int hour = 0;
      int minute = 0;
      int second = 0;
      double calorie = 0;

      if (currentLocation != null) {
        // distance : 달린 거리
        distance = GeolocatorHelper.getDistance(
          startLat,
          startLng,
          currentLocation.latitude,
          currentLocation.longitude,
        );
        hour = time.inHours; // hour : 달린 시간(시)
        minute = time.inMinutes; // minute : 달린 시간(분)
        second = time.inSeconds; // second : 달린 시간(초)
        if (time.inHours != 0) {
          speed = distance / time.inHours; // 평균 속력(km/h)
        }
        calorie = (time.inHours * 60 + time.inMinutes) *
            7.3; // calorie : 칼로리 소모 (분당 7.3kcal)
        state = RunningState(distance, speed, calorie, hour, minute, second);
      }
    });
  }

  // 현재 실행중인 타이머를 중지하는 함수
  void endRunning() {
    timer.cancel();
  }
}

final runningViewModel = NotifierProvider<RunningViewModel, RunningState>(
  () => RunningViewModel(),
);
