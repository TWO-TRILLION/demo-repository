import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_sprinchat_app/ui/widgets/pw_text_form_field.dart';

class UserRepository {
  const UserRepository();

// 컬렉션(User)의 userid 문서 읽기
  Future<void> getAll() async {
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

  Future<bool> insert({
    required String userid,
    required String userpw,
    required String nickname,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('User');
      DocumentReference documentRef = collectionRef.doc();
      Map<String, dynamic> data = {
        'userid': IdTextFormField,
        'userpw': PwTextFormField,
        'nickname': NicknameTextFormField,
      };
      await documentRef.set(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
