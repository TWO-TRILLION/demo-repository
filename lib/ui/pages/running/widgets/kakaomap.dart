import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakaomap_view_model.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class KakaoMap extends StatefulWidget {
  KakaoMap({
    super.key,
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  @override
  State<KakaoMap> createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.read(kakaomapViewModel.notifier).startMap();
        return ref.watch(kakaomapViewModel).mapView!;
        // return KakaoMapView(
        //   width: double.infinity,
        //   height: 300,
        //   kakaoMapKey: '08eebe69029ef27e6209ec2d97b79d29',
        //   lat: widget.lat,
        //   lng: widget.lng,
        // );
      },
    );
  }
}
