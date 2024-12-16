import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

class RunningPage extends StatefulWidget {
  RunningPage({required this.startLat, required this.startLng});

  final double startLat; // 러닝을 시작한 좌표(위도)
  final double startLng; // 러닝을 시작한 좌표(경도)

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(
            builder: (context, ref, child) {
              // 뷰모델 선언
              return Column(
                children: [
                  // 상단 '러닝' 문구
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '러닝',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // 지도 및 러닝 시작 버튼
                  SizedBox(
                    height: 350,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // 지도
                        KakaoMap(lat: widget.startLat, lng: widget.startLng),
                        // 러닝 시작 버튼
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                              onTap: () {
                                // 러닝 시작
                                if (!isRunning) {
                                  isRunning = true;
                                  final viewModel =
                                      ref.read(runningViewModel.notifier);
                                  viewModel.setLocation(); // 시작 위치 설정
                                  viewModel.startRunning(DateTime
                                      .now()); // 현재 시간으로 시작 시간 설정해서 러닝 시작
                                } else {
                                  isRunning = false;
                                  ref
                                      .read(runningViewModel.notifier)
                                      .endRunning();
                                }
                              },
                              // 버튼 디자인
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xff0070F0),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 5.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // 러닝 분석 정보 표시
                  RunningAnalysis(),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentPage: 'running'),
    );
  }
}
