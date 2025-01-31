import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/time_information.dart';

// 러닝 정보를 업데이트하는 위젯
class RunningAnalysis extends StatefulWidget {
  const RunningAnalysis({
    super.key,
  });

  @override
  State<RunningAnalysis> createState() => _RunningAnalysisState();
}

class _RunningAnalysisState extends State<RunningAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var analysis = ref.watch(runningViewModel);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
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
                    value: analysis.second % 60,
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
