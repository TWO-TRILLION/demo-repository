import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/result/widgets/result_box.dart';

class ResultxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                ResultBox('달린 시간', '30분', '동안'),
                ResultBox('달린 거리', '3km', '뛰고'),
                ResultBox('소모한 칼로리', '500kcal', '불태웠습니다'),
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
