import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';

class RunningViewModel extends AutoDisposeNotifier<List<double>> {
  @override
  List<double> build() {
    return [];
  }

  RunningViewModel({required this.startLat, required this.startLng});

  double? distance; // 달린 거리
  double? speed; // 평균 속력
  double? calorie; // 소모한 칼로리
  double? startTime; // 러닝을 시작한 시간
  double startLat; // 러닝을 시작한 지점의 위도
  double startLng; // 러닝을 시작한 지점의 경도

  Future<void> update() async {
    // 현재 위치 검색
    final currentLocation = await GeolocatorHelper.getPosition();

    if (currentLocation != null) {
      // 달린 거리 계산
      final currentDistance = GeolocatorHelper.getDistance(
        startLat,
        startLng,
        currentLocation.latitude,
        currentLocation.longitude,
      );
      // TODO : 현재 시간 기반으로 달린 시간 구하기
      // TODO : 평균 속력, 소모 칼로리 구하기
    }
  }
}
