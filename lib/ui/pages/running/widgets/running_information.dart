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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 150,
        width: 150,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
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
            Positioned(
              left: 5,
              child: SizedBox(
                width: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 값
                    Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    // 단위
                    Text(
                      unit,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RunningTimeInformation extends StatelessWidget {
  // 달린 시간 위젯
  RunningTimeInformation({
    required this.title, // 제목
    required this.hour, // 달린 시간(시)
    required this.minute, // 달린 시간(분)
  });

  final String title;
  final int hour;
  final int minute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 150,
        width: 150,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 시간
                Text(
                  '$hour',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // 시간 단위
                Text(
                  'h',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                // 분
                Text(
                  '$minute',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // 분 단위
                Text(
                  'm',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
