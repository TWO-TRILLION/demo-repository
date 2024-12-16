import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeLocation extends StatefulWidget {
  const HomeLocation({super.key});

  @override
  State<HomeLocation> createState() => _HomeLocationState();
}

class _HomeLocationState extends State<HomeLocation> {
  String currentLocation = '위치 불러오는 중...';
  final String vworldApiKey = '23B7F99C-6E94-3B38-8F2E-D43DFF88ADB5';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        currentLocation = '위치 불러오는 중...';
      });

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
        print('응답 내용: ${response.body}');

        if (response.statusCode == 200) {
          final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
          print('디코딩된 응답: $decodedResponse');

          if (decodedResponse['response']['status'] == 'OK') {
            final result = decodedResponse['response']['result'];
            if (result != null && result.isNotEmpty) {
              final structure = result[0]['structure'];
              setState(() {
                if (result[0]['text'] != null && result[0]['text'].isNotEmpty) {
                  currentLocation = result[0]['text'];
                } else {
                  currentLocation =
                      '${structure['level1']} ${structure['level2']} ${structure['level3']}';
                }
              });
            } else {
              setState(() {
                currentLocation = '주소를 찾을 수 없습니다';
              });
            }
          } else {
            print('API 응답 상태: ${decodedResponse['response']['status']}');
            setState(() {
              currentLocation = '${position.latitude}, ${position.longitude}';
            });
          }
        } else {
          setState(() {
            currentLocation = '${position.latitude}, ${position.longitude}';
          });
        }
      } else {
        setState(() {
          currentLocation = '위치를 가져올 수 없습니다';
        });
      }
    } catch (e) {
      print('오류 발생: $e');
      setState(() {
        currentLocation = '위치 서비스 오류';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            currentLocation,
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
