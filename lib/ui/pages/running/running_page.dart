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
  IconData icon = Icons.directions_walk; // 러닝 시작 버튼에 들어갈 아이콘

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  DateTime startTime = DateTime.now();
  bool isRunning = false;
  late Timer timer;

  @override
  void dispose() {
    timer = Timer(Duration(seconds: 1), () {});
    timer.cancel();
    super.dispose();
    print('running timer disposed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(
            builder: (context, ref, child) {
              // 뷰모델 선언
              late var analysis;
              return Column(
                children: [
                  // 상단 문구
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
                      Text(
                        '${DateTime.now().month}월 ${DateTime.now().day}일 ${DateTime.now().hour}시 ${DateTime.now().minute}분',
                        style: TextStyle(
                          color: Color(0xff979C9E),
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
                                  viewModel.update(startTime); // 시작 시간 설정
                                  analysis = ref.watch(runningViewModel);
                                  // timer =
                                  //     Timer.periodic(Duration(seconds: 1), (t) {
                                  //   var analysis = ref.watch(runningViewModel);
                                  //   // 1초 간격으로 러닝 버튼의 이미지 변경
                                  //   // widget.icon == Icons.directions_walk
                                  //   //     ? setState(() {
                                  //   //         widget.icon = Icons.directions_run;
                                  //   //       })
                                  //   //     : setState(() {
                                  //   //         widget.icon = Icons.directions_walk;
                                  //   //       });
                                  // });
                                  // 러닝 중지
                                } else {
                                  isRunning = false;
                                  //timer.cancel();
                                  setState(() {
                                    widget.icon = Icons.directions_walk;
                                  });
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
                                child: Icon(
                                  widget.icon,
                                  size: 30,
                                  color: Colors.white,
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
