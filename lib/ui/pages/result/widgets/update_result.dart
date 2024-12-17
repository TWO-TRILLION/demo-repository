import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

// 저장한 러닝 결과를 파라미터로 해서 RunningData를 선언하고
// UserRepository의 러닝 데이터 업데이트 함수를 호출
Future<void> updateResult(
  String userId,
  double distance,
  double calorie,
  double speed,
) async {
  final repo = UserRepository();
  final runningData =
      RunningData(distance: distance, calorie: calorie, speed: speed);

  repo.updateRunningdata(userId, runningData);
}
