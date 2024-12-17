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
  double currentLat;
  double currentLng;

  RunningState(
    this.distance,
    this.speed,
    this.calorie,
    this.hour,
    this.minute,
    this.second,
    this.currentLat,
    this.currentLng,
  );
}

class RunningViewModel extends Notifier<RunningState> {
  @override
  build() {
    return RunningState(0, 0, 0, 0, 0, 0, 37.56668, 126.978415);
  }

  double startLat = 0;
  double startLng = 0;
  late Timer timer;

  double distance = 0;
  double speed = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  double calorie = 0;
  double currentLat = 37.56668;
  double currentLng = 126.978415;

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
      if (currentLocation != null) {
        currentLat = currentLocation.latitude;
        currentLng = currentLocation.longitude;
      }
      var time = DateTime.now().difference(startTime); // 달린 시간

      if (currentLocation != null) {
        // distance : 달린 거리
        distance = GeolocatorHelper.getDistance(
          startLat,
          startLng,
          currentLat,
          currentLng,
        );
        hour = time.inHours; // hour : 달린 시간(시)
        minute = time.inMinutes; // minute : 달린 시간(분)
        second = time.inSeconds; // second : 달린 시간(초)
        double totalTime =
            (time.inHours + time.inMinutes / 60 + time.inSeconds / 3600);
        if (totalTime != 0) {
          speed = distance / totalTime; // 평균 속력(km/m)
        }
        calorie = (time.inHours * 3600 + time.inMinutes * 60 + time.inSeconds) *
            0.12; // calorie : 칼로리 소모 (초당 0.12kcal)
        state = RunningState(distance, speed, calorie, hour, minute, second,
            currentLocation.latitude, currentLocation.longitude);
      }
    });
  }

  // 현재 실행중인 타이머를 중지하는 함수
  RunningState endRunning() {
    timer.cancel();
    var temp = RunningState(
        distance, speed, calorie, hour, minute, second, currentLat, currentLng);
    state = RunningState(0, 0, 0, 0, 0, 0, 37.56668, 126.978415);
    return temp;
  }
}

final runningViewModel = NotifierProvider<RunningViewModel, RunningState>(
  () => RunningViewModel(),
);
