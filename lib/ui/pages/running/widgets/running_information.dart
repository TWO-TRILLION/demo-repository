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
      width: 120,
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.bottomRight,
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
              // 값이 세자릿수가 될 때부터는 소수점 표기하지 않음
              value > 99 ? value.toStringAsFixed(0) : value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // 단위
          Text(
            unit,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
