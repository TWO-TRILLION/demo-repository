import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sprinchat_app/data/model/chatmodel.dart';

class Chatrepository {
  // 컬렉션(Chatroom)의 chatroomid 문서 읽기
  Future<List<Chatmodel>> get(String chatroomid) async{

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('Chatroom');

    QuerySnapshot snapshot = await collectionRef.get();
    List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

    final docs = documentSnapshot.where((e){
      return e.id.contains(chatroomid);
    });

    final list = docs.map((e){
      final map = e.data() as Map<String,dynamic>;
      final newMap = {
        'chatroomid' : e.id,
        ...map,
      };

      return Chatmodel.fromJson(newMap);
    }).toList();

    return list;
  }
}