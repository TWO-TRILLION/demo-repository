import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/result/result_page.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_button.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

class RunningPage extends StatefulWidget {
  RunningPage(
      {required this.startLat,
      required this.startLng,
      required this.currentLocation});

  final double startLat; // 러닝을 시작한 좌표(위도)
  final double startLng; // 러닝을 시작한 좌표(경도)
  bool isRunning = false;
  String currentLocation;

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  bool isRunning = false;

  @override
  void dispose() {
    super.dispose();
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
              final runningButtonViewmodel = ref.read(buttonViewModel.notifier);
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
                                runningButtonViewmodel.startRunning();
                                final viewModel =
                                    ref.read(runningViewModel.notifier);
                                viewModel.setLocation(); // 시작 위치 설정
                                viewModel.startRunning(
                                    DateTime.now()); // 현재 시간으로 시작 시간 설정해서 러닝 시작
                              } else {
                                isRunning = false;
                                runningButtonViewmodel.stopRunning();
                                RunningState result = ref
                                    .read(runningViewModel.notifier)
                                    .endRunning();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(result),
                                  ),
                                );
                              }
                            },
                            // 버튼 디자인
                            child: RunningButton(
                                ref.watch(buttonViewModel).isRunning),
                          ),
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
      bottomNavigationBar: CustomNavigationBar(
          currentPage: 'running'),
    );
  }
}
