import 'package:flutter/material.dart';

class TimeInformation extends StatelessWidget {
  const TimeInformation({
    super.key,
    required this.value,
    required this.unit,
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
            fontSize: 70,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 5),
        Text(
          unit,
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
