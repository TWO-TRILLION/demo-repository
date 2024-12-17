import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:flutter_sprinchat_app/ui/pages/result/widgets/result_box.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';

class ResultPage extends StatelessWidget {
  ResultPage(
    this.analysis,
    this.userId,
    //this.user,
  );
  final userId;
  RunningState analysis;
  //UserModel user;

  @override
  Widget build(BuildContext context) {
    String runningTime =
        '${analysis.hour}시간 ${analysis.minute}분 ${analysis.second}초';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 타이틀
                Text(
                  '러닝 결과',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 30),
                ResultBox('달린 시간', runningTime, '', '동안',
                    Icons.timer_outlined), // 달린 시간
                ResultBox('달린 거리', analysis.distance.toStringAsFixed(2), 'km',
                    '뛰고', Icons.straighten), // 달린 거리
                ResultBox(
                    '소모한 칼로리',
                    analysis.calorie.toStringAsFixed(2),
                    'kcal',
                    '불태웠습니다',
                    Icons.local_fire_department_outlined), // 소모한 칼로리
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('러닝 기록을 저장하시겠습니까?'),
                        actions: <CupertinoDialogAction>[
                          // 저장하고 종료할 시
                          CupertinoDialogAction(
                            isDefaultAction: false,
                            onPressed: () {
                              Navigator.pop(context);
                              // 홈페이지로 라우팅
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MyHome();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              '저장 안 함',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // 저장하지 않고 종료할 시
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                              // 러닝 기록 업데이트
                              updateResult(
                                userId,
                                analysis.distance,
                                analysis.calorie,
                                analysis.speed,
                              );
                              // 홈페이지로 라우팅
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MyHome();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              '저장',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text('러닝 마치기'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 결과 업데이트 함수
  Future<void> updateResult(
    String userId,
    double distance,
    double calorie,
    double speed,
  ) async {
    final repo = UserRepository();
    final runningData =
        RunningData(distance: distance, calorie: calorie, speed: speed);

    repo.updateRunningdata(userId, runningData);
  }
}
