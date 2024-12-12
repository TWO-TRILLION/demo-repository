import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static Future<Position?> getPosition() async {
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
    // 위도 : position.latitude
    // 경도 : position.longitude
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    return position;
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
