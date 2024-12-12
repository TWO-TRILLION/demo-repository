import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';

class RunningState {
  double? distance;
  double? speed;
  double? calorie;
  DateTime time;

  RunningState(
    this.distance,
    this.speed,
    this.calorie,
    this.time,
  );
}

class RunningViewModel extends Notifier<RunningState> {
  @override
  build() {
    return RunningState(distance, speed, calorie, time);
  }

  RunningViewModel(
      {required this.startLat,
      required this.startLng,
      required this.startTime});

  DateTime startTime; // 러닝을 시작한 시간
  double startLat; // 러닝을 시작한 지점의 위도
  double startLng; // 러닝을 시작한 지점의 경도

  double? distance;
  double? speed;
  double? calorie;
  var time;

  Future<void> update() async {
    // 현재 위치 검색
    final currentLocation = await GeolocatorHelper.getPosition();

    if (currentLocation != null) {
      // 달린 거리 계산
      final distance = GeolocatorHelper.getDistance(
        startLat,
        startLng,
        currentLocation.latitude,
        currentLocation.longitude,
      );
      // 달린 시간
      time = DateTime.now().difference(startTime);
      // 평균 속력(km/h)
      speed = distance / time.inHours;
      // 칼로리 소모 : 분당 4
      calorie = time.inMinutes / 4;

      state = RunningState(distance, speed, calorie, time);
    }
  }
}
