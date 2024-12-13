import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/time_information.dart';

class RunningAnalysis extends StatelessWidget {
  const RunningAnalysis({
    super.key,
    required this.startTime,
    required this.startLat,
    required this.startLng,
  });

  final DateTime startTime;
  final double startLat;
  final double startLng;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.read(runningViewModel.notifier);
        viewModel.update(startTime, startLat, startLng);
        final analysis = ref.watch(runningViewModel);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '러닝',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${DateTime.now().month}월 ${DateTime.now().day}일 ${DateTime.now().hour}시 ${DateTime.now().minute}분',
                    style: TextStyle(
                      color: Color(0xff979C9E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xff979C9E),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeInformation(
                    value: analysis.hour,
                    unit: 'h',
                  ),
                  SizedBox(width: 10),
                  TimeInformation(
                    value: analysis.minute,
                    unit: 'm',
                  ),
                  SizedBox(width: 10),
                  TimeInformation(
                    value: analysis.second,
                    unit: 's',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RunningInformation('달린 거리', analysis.distance, 'km'),
                  RunningInformation('평균 속력', analysis.speed, 'km/h'),
                  RunningInformation('소모한 칼로리', analysis.calorie, 'kcal'),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
