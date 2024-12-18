import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';

class HomeLocation extends ConsumerStatefulWidget {
  const HomeLocation({
    super.key,
    required this.onLocationChanged,
  });

  final Function(String) onLocationChanged;

  @override
  ConsumerState<HomeLocation> createState() => _HomeLocationState();
}

class _HomeLocationState extends ConsumerState<HomeLocation> {
  final String vworldApiKey = '23B7F99C-6E94-3B38-8F2E-D43DFF88ADB5';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getCurrentLocation());
  }

  Future<void> _getCurrentLocation() async {
    try {
      ref.read(locationViewModelProvider.notifier).setLocation('위치 불러오는 중...');

      final position = await GeolocatorHelper.getPosition();
      if (position != null) {
        final String url = 'http://api.vworld.kr/req/address'
            '?service=address'
            '&request=getAddress'
            '&version=2.0'
            '&crs=epsg:4326'
            '&point=${position.longitude},${position.latitude}'
            '&format=json'
            '&type=both'
            '&zipcode=true'
            '&simple=false'
            '&key=$vworldApiKey';

        print('요청 URL: $url');

        final response = await http.get(Uri.parse(url));

        print('응답 상태 코드: ${response.statusCode}');
        print('응답 : ${response.body}');

        if (response.statusCode == 200) {
          final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
          print('디코딩된 응답: $decodedResponse');

          if (decodedResponse['response']['status'] == 'OK') {
            final result = decodedResponse['response']['result'];
            if (result != null && result.isNotEmpty) {
              final structure = result[0]['structure'];
              final String address = result[0]['text'] != null &&
                      result[0]['text'].isNotEmpty
                  ? result[0]['text']
                  : '${structure['level1']} ${structure['level2']} ${structure['level3']}';

              if (mounted) {
                ref
                    .read(locationViewModelProvider.notifier)
                    .setLocation(address);
                widget.onLocationChanged(address);
              }
            } else {
              if (mounted) {
                ref
                    .read(locationViewModelProvider.notifier)
                    .setLocation('주소를 찾을 수 없습니다');
              }
            }
          } else {
            print('API 응답 상태: ${decodedResponse['response']['status']}');
            if (mounted) {
              ref
                  .read(locationViewModelProvider.notifier)
                  .setLocation('${position.latitude}, ${position.longitude}');
            }
          }
        } else {
          if (mounted) {
            ref
                .read(locationViewModelProvider.notifier)
                .setLocation('${position.latitude}, ${position.longitude}');
          }
        }
      } else {
        if (mounted) {
          ref
              .read(locationViewModelProvider.notifier)
              .setLocation('위치를 가져올 수 없습니다');
        }
      }
    } catch (e) {
      print('오류 발생: $e');
      if (mounted) {
        ref.read(locationViewModelProvider.notifier).setLocation('위치 서비스 오류');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationViewModelProvider);
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh, size: 16),
          onPressed: _getCurrentLocation,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          color: Colors.grey,
        ),
      ],
    );
  }
}
