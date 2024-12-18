import 'package:flutter/material.dart';

// 타이머 위젯
class TimeInformation extends StatelessWidget {
  const TimeInformation({
    super.key,
    required this.value, // 데이터 값
    required this.unit, // 단위(시간, 분, 초)
  });

  final int value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 5),
        Text(
          unit,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
