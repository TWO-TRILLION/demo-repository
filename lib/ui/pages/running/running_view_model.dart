import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';

class RunningViewModel extends AutoDisposeNotifier<List<double>> {
  @override
  List<double> build() {
    return [];
  }

  RunningViewModel(
      {required this.startLat,
      required this.startLng,
      required this.startTime});

  DateTime startTime; // 러닝을 시작한 시간
  double startLat; // 러닝을 시작한 지점의 위도
  double startLng; // 러닝을 시작한 지점의 경도

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
      final runningTime = DateTime.now().difference(startTime);
      // TODO : 평균 속력, 소모 칼로리 구하기
      final speed = distance / runningTime.inHours;
      // 칼로리 소모 : 분당 4
      final calorie = runningTime.inMinutes / 4;
    }
  }
}
