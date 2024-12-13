import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/data/model/chatmodel.dart';

class Chatrepository {
  // 컬렉션(Chatroom)의 chatroomid 문서 읽기
  Future<List<Chatmodel>> get(String chatroomid) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('Chatroom');

      QuerySnapshot snapshot = await collectionRef.get();
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

      final docs = documentSnapshot.where((e) {
        return e.id.contains(chatroomid);
      });

      final list = docs.map((e) {
        final map = e.data() as Map<String, dynamic>;
        final newMap = {
          'chatroomid': e.id,
          ...map,
        };

        return Chatmodel.fromJson(newMap);
      }).toList();

      return list;
    } catch (e) {
      print('채팅 데이터 없음');
    }
    return [];
  }

  // 실시간 채팅 읽기 (스트림용)
  Stream<List<Chatmodel>> getStream(String chatroomid) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('Chatroom');

      final stream = collectionRef.snapshots();

      final newStream = stream.map((snapshot) {
        final docs = snapshot.docs.where((doc) {
          return doc.id.contains(chatroomid);
        });

        final list = docs.map((doc) {
          final map = doc.data() as Map<String, dynamic>;
          final newMap = {
            'chatroomid': chatroomid,
            ...map,
          };

          return Chatmodel.fromJson(newMap);
        }).toList();

        return list;
      });

      return newStream;
    } catch (e) {
      print('채팅 데이터 없음');
    }
    return Stream.empty();
  }

  // 컬렉션(Chatroom)의 chatroomid 문서 쓰기
  Future<void> insert(
      {required String chatroomid,
      required DateTime updatetime,
      required List<String> member,
      required List<Map<String, dynamic>> chats}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('Chatroom');

      final docRef = collectionRef.doc(chatroomid);

      Map<String,dynamic> map = {
        "chats": chats,
        "member": member,
        "updatetime": updatetime.toIso8601String(),
      };

      await docRef.set(map);
    } catch (e) {
      print('쓰기 실패');
    }
  }

  // 컬렉션(Chatroom)의 chatroomid 문서 업데이트
  Future<void> update(String chatroomid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('Chatroom');

    final docRef = collectionRef.doc(chatroomid);

    Map<String,dynamic> map ={
      "updatetime" : DateTime.now().toIso8601String(),
    };

    await docRef.update(map);
  }
}
