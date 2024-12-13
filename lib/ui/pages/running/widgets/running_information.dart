import 'package:flutter/material.dart';

class RunningInformation extends StatelessWidget {
  // 달린 거리, 평균 속력, 소모한 칼로리 위젯
  RunningInformation(
    this.title, // 제목
    this.value, // 값
    this.unit, // 단위
  );

  final String title;
  final double value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 110,
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          // 제목
          Positioned(
            top: 20,
            left: 5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          // 값
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // 단위
          Positioned(
            bottom: 10,
            right: 5,
            child: Text(
              unit,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
