import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class KakaoMap extends StatelessWidget {
  const KakaoMap({
    super.key,
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return KakaoMapView(
      width: double.infinity,
      height: 300,
      kakaoMapKey: '08eebe69029ef27e6209ec2d97b79d29',
      lat: lat,
      lng: lng,
    );
  }
}
