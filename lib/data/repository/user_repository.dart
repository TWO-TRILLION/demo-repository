import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class UserRepository {
  const UserRepository();

// 컬렉션(User)의 userid 문서 읽기
  Future<void> getAll() async {
    // FirebaseFirestore 객체 가져오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //FirebaseFirestore 객체에서 컬렉션메서드로 User 컬렉션에 대한 참조 가져오기
    // 참조만 저장
    CollectionReference collectionRef = firestore.collection('User');

    //컬렉션 참조에서 모든 문서 가져오기
    QuerySnapshot snapshot = await collectionRef.get();

    //QuerySnapshot 객체 내에 docs 필드에 있는 문서조회결과
    List<QueryDocumentSnapshot> documentSnapshots = snapshot.docs;

    //QueryDocumentSnapshot에서 data 메서드로 진짜 데이터 가져오기
    for (var docSnapshot in documentSnapshots) {
      print(docSnapshot.id);
      print(docSnapshot.data());
    }
  }

  Future<void> insert() async {
    //Firebase 객체 가져오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //FirebaseFirestore 객체에서 collection 메서드로 User 컬렉션에 대한 참조 가져오기
    // User 컬렉션에 대한 참조만 저장
    CollectionReference collectionRef = firestore.collection('User');

    //컬렉션 참조에서 문서참조 만들기
    //ID 를 파라미터로 넣지 않으면 문서 생성시 새로운 ID 부여
    DocumentReference documentRef = collectionRef.doc();

    //문서에 넣을 데이터를 Map 타입으로 생성
    Map<String, dynamic> data = {
      'userid': IdTextFormField,
      'userpw': PwTextFormField,
      'nickname': NicknameTextFormField,
    };
    await documentRef.set(data);
  }
}
