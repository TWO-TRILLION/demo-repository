import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';

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
        return Column(
          children: [
            RunningInformation(title: '달린 거리', value: analysis.distance!),
            RunningInformation(title: '평균 속력', value: analysis.speed!),
            RunningInformation(title: '소모한 칼로리', value: analysis.calorie!),
            SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
