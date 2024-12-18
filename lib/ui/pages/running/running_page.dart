import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/result/result_page.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/button_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_button.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/unavailable_navigationbar.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';
import 'package:lottie/lottie.dart';

class RunningPage extends ConsumerStatefulWidget {
  @override
  RunningPageState createState() => RunningPageState();
}

class RunningPageState extends ConsumerState<RunningPage> {
  bool isRunning = false;

  late final String userId; // 유저 id 뷰모델
  late final dynamic runningButton; // 러닝중/러닝 종료 상태 관리 뷰모델
  late final dynamic running; // 러닝 데이터 분석 뷰모델

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    userId = ref.read(userViewModelProvider);
    runningButton = ref.read(buttonViewModel.notifier);
    running = ref.read(runningViewModel.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 상단 문구
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '러닝',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // 화면 상단 애니메이션 - LottieFiles 애니메이션 사용
                      SizedBox(
                        height: 200,
                        child: Lottie.asset('assets/json/lottie.json'),
                      ),
                      // 러닝 시작 버튼
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            // 러닝 시작
                            if (!isRunning) {
                              isRunning = true;
                              runningButton.startRunning(); // 러닝 버튼 상태 변경
                              running.setLocation(); // 시작 위치 설정
                              running.startRunning(
                                  DateTime.now()); // 현재 시간으로 시작 시간 설정해서 러닝 시작
                              // 러닝 종료
                            } else {
                              isRunning = false;
                              runningButton.stopRunning(); // 러닝 버튼 상태 변경
                              RunningState result =
                                  running.endRunning(); // 러닝 분석 결과 저장
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                      analysis: result, userId: userId),
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
            )),
      ),
      // 러닝중일 때는 bottomNavigationbar를 눌러도 화면을 전환할 수 없게 설정
      bottomNavigationBar: !ref.watch(buttonViewModel).isRunning
          ? CustomNavigationBar(currentPage: 'running')
          : UnavailableNavigationbar(currentPage: 'running'),
    );
  }
}
