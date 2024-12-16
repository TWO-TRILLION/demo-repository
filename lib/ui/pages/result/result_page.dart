import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/result/widgets/result_box.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';

class ResultPage extends StatelessWidget {
  ResultPage(this.analysis);

  RunningState analysis;

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
                Text(
                  '러닝 결과',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 30),
                ResultBox('달린 시간', runningTime, '', '동안', Icons.timer_outlined),
                ResultBox(
                    '달린 거리', analysis.distance, 'km', '뛰고', Icons.straighten),
                ResultBox('소모한 칼로리', analysis.calorie, 'kcal', '불태웠습니다',
                    Icons.local_fire_department_outlined),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('러닝 마치기'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
