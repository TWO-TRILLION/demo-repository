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

  Future<void> update(
    DateTime startTime,
    double startLat,
    double startLng,
  ) async {
    final currentLocation = await GeolocatorHelper.getPosition(); // 현재 위치 좌표
    var time = DateTime.now().difference(startTime); // 달린 시간

    if (currentLocation != null) {
      // distance : 달린 거리
      final distance = GeolocatorHelper.getDistance(
        startLat,
        startLng,
        currentLocation.latitude,
        currentLocation.longitude,
      );
      state.hour = time.inHours; // hour : 달린 시간(시)
      state.minute = time.inMinutes; // minute : 달린 시간(분)
      state.second = time.inSeconds; // second : 달린 시간(초)
      if (time.inHours != 0) {
        state.speed = distance / time.inHours; // 평균 속력(km/h)
      }
      state.calorie = (time.inHours * 60 + time.inMinutes) *
          4; // calorie : 칼로리 소모 (분당 4kcal)
    }
  }
}

final runningViewModel = NotifierProvider<RunningViewModel, RunningState>(
  () => RunningViewModel(),
);
