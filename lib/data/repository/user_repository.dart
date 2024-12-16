import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;

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
          'kcal': runningData.kcal,
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
          await firestore.collection('user').doc(id).get();
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
}
