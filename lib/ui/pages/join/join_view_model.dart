import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

class JoinViewModel {
  final UserRepository userRepository;

  JoinViewModel(this.userRepository);

  Future<bool> checkDuplicatedId(String id) async {
    return await userRepository.checkDuplicatedId(id);
  }

  Future<void> createUser(String id, String pw, String nickname) async {
    await userRepository.insert(
      userid: id,
      userpw: pw,
      nickname: nickname,
      lastchatroomid: '',
      runningData: RunningData(distance: 0, calorie: 0, speed: 0),
      imageUrl: '',
    );
  }
}
