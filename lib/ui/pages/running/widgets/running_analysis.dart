import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_information.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/time_information.dart';

class RunningAnalysis extends StatefulWidget {
  RunningAnalysis({
    super.key,
    required this.analysis,
  });

  var analysis;

  @override
  State<RunningAnalysis> createState() => _RunningAnalysisState();
}

class _RunningAnalysisState extends State<RunningAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeInformation(
                    value: widget.analysis.hour,
                    unit: 'h',
                  ),
                  SizedBox(width: 10),
                  TimeInformation(
                    value: widget.analysis.minute,
                    unit: 'm',
                  ),
                  SizedBox(width: 10),
                  TimeInformation(
                    value: widget.analysis.second % 60,
                    unit: 's',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RunningInformation('달린 거리', widget.analysis.distance, 'km'),
                  RunningInformation('평균 속력', widget.analysis.speed, 'km/h'),
                  RunningInformation(
                      '소모한 칼로리', widget.analysis.calorie, 'kcal'),
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
