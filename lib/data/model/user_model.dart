class RunningData {
  int distance;
  int kcal;
  int speed;

  RunningData({
    required this.distance,
    required this.kcal,
    required this.speed,
  });

  RunningData.fromJson(Map<String, dynamic> json)
      : this(
          distance: json['distance'],
          kcal: json['kcal'],
          speed: json['speed'],
        );
}

class UserModel {
  String userid;
  String userpw;
  String nickname;
  String? lastchatroomid;
  RunningData? runningData;
  String? imageUrl;

  UserModel({
    required this.userid,
    required this.userpw,
    required this.nickname,
    required this.lastchatroomid,
    required this.runningData,
    required this.imageUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          userid: json['userid'],
          userpw: json['userpw'],
          nickname: json['nickname'],
          lastchatroomid: json['lastchatroomid'],
          runningData: RunningData.fromJson(json['runningData']),
          imageUrl: json['imageUrl'],
        );

  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "userpw": userpw,
      "nickname": nickname,
      "lastchatroomid": lastchatroomid,
      "runningData": runningData,
      "imageUrl": imageUrl,
    };
  }
}
