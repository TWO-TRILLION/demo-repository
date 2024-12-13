import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_view_model.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/widgets/time_information.dart';

class RunningButton extends StatelessWidget {
  RunningButton(this.analysis);

  final RunningState analysis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${DateTime.now().month}월 ${DateTime.now().day}일 ${DateTime.now().hour}시 ${DateTime.now().minute}분',
              style: TextStyle(
                color: Color(0xff979C9E),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
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
          ],
        ),
      ),
    );
  }
}
