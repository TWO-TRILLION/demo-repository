import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class KakaomapState {
  Position currentPosition;
  KakaomapState({required this.currentPosition});
}

// class KakaomapViewModel extends Notifier<KakaomapState> {
//   @override
//   KakaomapState build() {
//     return KakaomapState(currentPosition: currentPosition);
//   }

// }
