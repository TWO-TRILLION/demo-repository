import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/core/geolocator_helper.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/kakao_map.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/running_analysis.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';
import 'package:geolocator/geolocator.dart';

class RunningPage extends StatefulWidget {
  RunningPage({required this.startLat, required this.startLng});

  double startLat;
  double startLng;
  Color boxColor = Color(0xff0070F0);
  IconData icon = Icons.directions_walk;

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  double distance = 0;
  double speed = 0;
  double calorie = 0;
  DateTime? time;
  DateTime startTime = DateTime.now();
  bool isRunning = false;
  late Timer timer;

  @override
  void dispose() {
    timer = Timer(Duration(seconds: 1), () {});
    timer.cancel();
    super.dispose();
    print('running timer disposed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.read(runningViewModel.notifier);
              viewModel.setLocation();
              viewModel.update(startTime);
              var analysis = ref.watch(runningViewModel);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '러닝',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
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
                  SizedBox(height: 30),
                  // Container(
                  //   width: double.infinity,
                  //   height: 10,
                  //   color: widget.boxColor,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Timer.periodic(Duration(seconds: 1), (t) {
                  //         widget.boxColor != Colors.yellow
                  //             ? setState(() {
                  //                 widget.boxColor = Colors.yellow;
                  //               })
                  //             : setState(() {
                  //                 widget.boxColor = Colors.grey;
                  //               });
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 350,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        KakaoMap(lat: widget.startLat, lng: widget.startLng),
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                              onTap: () {
                                if (!isRunning) {
                                  isRunning = true;
                                  timer =
                                      Timer.periodic(Duration(seconds: 1), (t) {
                                    analysis = ref.watch(runningViewModel);
                                    widget.icon == Icons.directions_walk
                                        ? setState(() {
                                            widget.icon = Icons.directions_run;
                                          })
                                        : setState(() {
                                            widget.icon = Icons.directions_walk;
                                          });
                                  });
                                } else {
                                  isRunning = false;
                                  timer.cancel();
                                  setState(() {
                                    widget.icon = Icons.directions_walk;
                                  });
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: widget.boxColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 5.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  RunningAnalysis(analysis: analysis),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentPage: 'running'),
    );
  }
}
