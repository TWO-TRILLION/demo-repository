import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 러닝 버튼의 디자인을 정하는 위젯
class RunningButton extends StatelessWidget {
  RunningButton(this.isRunning);
  bool isRunning = false;

  final Color runningColor = Color(0xff0070F0); // 러닝 중에 사용할 색상
  final Color stopColor = Color(0xff000000); // 러닝 전/러닝 종료 이후 사용할 색상

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isRunning
            ? Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: runningColor, width: 3),
                  gradient: LinearGradient(
                    stops: [0.2, 1.0],
                    colors: [
                      const Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 208, 208, 208)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.5, 1.0],
                      colors: [
                        const Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 169, 169, 169)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '러닝 종료',
                        style: TextStyle(
                          color: runningColor,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.directions_run,
                        color: runningColor,
                        size: 30,
                      )
                    ],
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: stopColor, width: 3),
                  gradient: LinearGradient(
                    stops: [0.3, 1.0],
                    colors: [
                      const Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 208, 208, 208)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.5, 1.0],
                      colors: [
                        const Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 169, 169, 169)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '러닝 시작',
                        style: TextStyle(
                          color: stopColor,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.directions_run,
                        color: stopColor,
                        size: 30,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
