import 'dart:convert';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Runningdata model test', () {
    String dummyData = """
    {
      "distance": 0,
      "calorie": 0,
      "speed" : 0
    }
""";

    Map<String, dynamic> map = jsonDecode(dummyData);
    RunningData run = RunningData.fromJson(map);
    expect(run.distance, 0);
  });
}
