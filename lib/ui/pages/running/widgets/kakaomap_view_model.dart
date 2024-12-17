import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class KakaomapState {
  KakaomapState(double lat, double lng) {
    mapView = KakaoMapView(
      width: double.infinity,
      height: 300,
      kakaoMapKey: '08eebe69029ef27e6209ec2d97b79d29',
      lat: lat,
      lng: lng,
    );
  }
  KakaoMapView? mapView;
}

class KakaomapViewModel extends Notifier<KakaomapState> {
  @override
  KakaomapState build() {
    return KakaomapState(37.56668, 126.978415);
    //return KakaomapState(0, 0);
  }

  late Timer timer;

  void startMap() async {
    timer = Timer.periodic(Duration(seconds: 5), (t) async {
      var currentPosition = await GeolocatorHelper.getPosition();
      if (currentPosition != null) {
        state =
            KakaomapState(currentPosition.latitude, currentPosition.longitude);
      }
    });
  }

  void endMap() {
    timer.cancel();
  }
}

final kakaomapViewModel = NotifierProvider<KakaomapViewModel, KakaomapState>(
  () => KakaomapViewModel(),
);
