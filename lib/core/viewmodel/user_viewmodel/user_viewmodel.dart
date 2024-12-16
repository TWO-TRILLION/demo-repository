import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewmodel extends StateNotifier<String> {
  UserViewmodel() : super('위치 불러오는 중...');

  void setUserId(String userid) {
    state = userid;
  }

  String getUserId() {
    return state;
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewmodel, String>((ref) {
  return UserViewmodel();
});
