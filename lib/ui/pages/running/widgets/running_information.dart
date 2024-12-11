import 'package:flutter/material.dart';

class RunningInformation extends StatelessWidget {
  const RunningInformation({
    super.key,
    required this.value,
    required this.title,
  });

  final double value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w200,
          ),
        ),
        Text(
          '$value km',
          style: TextStyle(
            fontSize: 52,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
