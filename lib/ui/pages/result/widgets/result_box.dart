import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  ResultBox(this.title, this.value, this.unit, this.message, this.icon);

  final IconData icon; // 좌상단 아이콘 종류
  final String title; // 제목
  final dynamic value; // 기록값
  final String message; // 박스 하단 메시지
  final String unit; // 데이터 단위

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 340,
        height: 140,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 7))
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // 아이콘 들어 있는 원
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xffF2F8FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Color(0xff0070F0),
                  ),
                ),
                SizedBox(width: 10),
                // 박스 제목
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 값
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                // 단위
                Text(
                  unit,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            // 메시지
            Text(
              message,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
