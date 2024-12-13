class RunningData {
  int distance;
  int kcal;
  int speed;

  RunningData({
    required this.distance,
    required this.kcal,
    required this.speed,
  });
}

class UserModel {
  String userid;
  String userpw;
  String nickname;

  UserModel({
    required this.userid,
    required this.userpw,
    required this.nickname,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          userid: json['userid'],
          userpw: json['userpw'],
          nickname: json['nickname'],
        );

  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "userpw": userpw,
      "nickname": nickname,
    };
  }
}
