import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static Future<Position?> getPosition() async {
    try {
      // 권한 묻기
      final permission = await Geolocator.checkPermission();

      // 권한이 없는 경우 권한을 요청한다.
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        final permission2 = await Geolocator.requestPermission();
        // 권한 요청이 거부당한 경우 null을 반환한다.
        if (permission2 == LocationPermission.denied ||
            permission2 == LocationPermission.deniedForever) {
          return null;
        }
      }

      // 현재 위치를 position에 저장한다.
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        // 에뮬레이터/시뮬레이터에서 테스트할 때 사용할 기본 위치 (서울시청)
        position = Position(
          latitude: 37.5666805,
          longitude: 126.9784147,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }
      return position;
    } catch (e) {
      print('위치 가져오기 오류: $e');
      return null;
    }
  }

  // 두 좌표 사이의 거리를 반환한다.
  static double getDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
