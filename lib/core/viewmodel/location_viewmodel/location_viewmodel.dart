import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationViewModel extends StateNotifier<String> {
  LocationViewModel() : super('위치 불러오는 중...');

  void setLocation(String location) {
    state = location;
  }

  String getLocation() {
    return state;
  }
}

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModel, String>((ref) {
  return LocationViewModel();
});
