import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';

class RunningViewModel extends AutoDisposeNotifier<List<double>> {
  @override
  List<double> build() {
    return [];
  }

  RunningViewModel({required this.startLat, required this.startLng});

  double? distance;
  double? speed;
  double? calorie;
  double? startTime;
  double startLat;
  double startLng;

  Future<void> update() async {
    final currentLocation = await GeolocatorHelper.getPosition();
    if (currentLocation != null) {
      final currentDistance = GeolocatorHelper.getDistance(
        startLat,
        startLng,
        currentLocation.latitude,
        currentLocation.longitude,
      );
    }
  }
}
