import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<List<UserModel>?> getAll() async {
    try {
      final collectionRef = firestore.collection('User');
      final result = await collectionRef.get();
      final docs = result.docs;

      return docs.map((doc) {
        final map = doc.data();
        final newMap = {
          'id': doc.id,
          ...map as Map<String, dynamic>,
        };
        return UserModel.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> insert({
    required String userid,
    required String userpw,
    required String nickname,
    required String lastchatroomid,
    required RunningData runningData,
    required String imageUrl,
  }) async {
    try {
      CollectionReference collectionRef = firestore.collection('User');
      DocumentReference documentRef = collectionRef.doc(userid);
      Map<String, dynamic> data = {
        'userpw': userpw,
        'nickname': nickname,
        'lastchatroomid': '',
        'runningData': ({
          'distance': runningData.distance,
          'calorie': runningData.calorie,
          'speed': runningData.speed,
        }),
        'imageUrl': '',
      };
      await documentRef.set(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> getOne(String id) async {
    try {
      CollectionReference collectionRef = firestore.collection('User');
      QuerySnapshot snapshot = await collectionRef.get();
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;
      final docs = documentSnapshot.where((e) {
        return e.id.contains(id);
      });

      final list = docs.map(
        (e) {
          final map = e.data() as Map<String, dynamic>;
          final newMap = {
            'userid': e.id,
            ...map,
          };
          return UserModel.fromJson(newMap);
        },
      ).toList();
      return list[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> checkDuplicatedId(String id) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('User').doc(id).get();
      // print(snapshot.exists);
      return snapshot.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> update({
  //   required String userid,
  //   required String userpw,
  //   required String nickname,
  //   required String lastchatroomid,
  //   required RunningData runningData,
  //   required String imageUrl,
  //   required String id,
  // }) async {
  //   try {
  //     CollectionReference collectionRef = firestore.collection('User');
  //     DocumentReference documentRef = collectionRef.doc(id);
  //     Map<String, dynamic> data = {
  //       'userid': IdTextFormField,
  //       'userpw': PwTextFormField,
  //       'nickname': NicknameTextFormField,
  //       'lastchatroomid': lastchatroomid,
  //       'runningData': runningData,
  //       'imageUrl': imageUrl,
  //     };
  //     documentRef.update(data);
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // 유저의 LastChatRoomID 업데이트
  Future<void> updateLastChatRoomId(String userid, String chatroomid) async {
    try {
      CollectionReference collectionRef = firestore.collection('User');
      final docRef = collectionRef.doc(userid);

      Map<String, dynamic> map = {
        "lastchatroomid": chatroomid,
      };

      await docRef.update(map);
    } catch (e) {
      print('없는 아이디 입니다. $e');
    }
  }

  Future<void> updateNickname(String userId, String newNickname) async {
    try {
      await firestore.collection('User').doc(userId).update({
        'nickname': newNickname,
      });
    } catch (e) {
      print('닉네임 업데이트 오류: $e');
      throw Exception('닉네임 업데이트 실패');
    }
  }

  Future<void> updateRunningdata(String userId, RunningData data) async {
    final json = jsonEncode(data);
    try {
      await firestore.collection('User').doc(userId).update({
        'runningData': json,
      });
    } catch (e) {
      print('러닝 기록 등록 오류: $e');
      throw Exception('러닝 기록 등록 실패');
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await firestore.collection('User').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        data['userid'] = doc.id;
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print('사용자 정보 가져오기 오류: $e');
      return null;
    }
  }

  Future<void> updateUserImage(String userId, String imagePath) async {
    try {
      final file = File(imagePath);
      final ref = storage.ref().child('profile_images').child('$userId.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      await firestore.collection('User').doc(userId).update({
        'imageUrl': url,
      });
    } catch (e) {
      print('프로필 이미지 업데이트 오류: $e');
      throw Exception('프로필 이미지 업데이트 실패');
    }
  }
}
