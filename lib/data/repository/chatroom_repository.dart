import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../model/chatroom_model.dart';

class ChatroomRepository {
  final firestore = FirebaseFirestore.instance;

  // 테스트용 채팅방 생성 메서드
  Future<void> createTestChatroom() async {
    try {
      print('테스트 채팅방 생성 시도...');

      // Firestore 연결 테스트
      try {
        await firestore.collection('test').limit(1).get();
        print('Firestore 연결 성공');
      } catch (e) {
        print('Firestore 연결 실패: $e');
        rethrow;
      }

      // 이미 존재하는지 확인
      final existing = await firestore
          .collection('Chatroom')
          .where('location', isEqualTo: '부산광역시 동래구 온천동')
          .get();

      if (existing.docs.isEmpty) {
        final docRef = await firestore.collection('Chatroom').add({
          'location': '부산광역시 동래구 온천동',
          'members': 5,
          'rating': 4.5,
          'geopoint': GeoPoint(35.211882, 129.066709),
        });
        print('테스트 채팅방 생성 완료 - ID: ${docRef.id}');
      } else {
        print('테스트 채팅방이 이미 존재함 - ${existing.docs.length}개');
      }
    } catch (e, stackTrace) {
      print('테스트 채팅방 생성 오류: $e');
      print('스택 트레이스: $stackTrace');
      if (e is FirebaseException) {
        print('Firebase 오류 코드: ${e.code}');
        print('Firebase 오류 메시지: ${e.message}');
      }
      rethrow;
    }
  }

  Future<List<ChatroomModel>> getNearbyChats(
      Position currentPosition, double radiusInKm) async {
    try {
      print('Firestore 채팅방 조회 시작...');

      // Firestore 연결 확인
      print('Firestore 연결 확인...');
      await firestore.collection('Chatroom').limit(1).get();

      final center =
          GeoPoint(currentPosition.latitude, currentPosition.longitude);
      print('현재 위치(GeoPoint): ${center.latitude}, ${center.longitude}');

      print('채팅방 데이터 조회 중...');
      final snapshot = await firestore.collection('Chatroom').get();

      if (snapshot.docs.isEmpty) {
        print('채팅방이 하나도 없습니다.');
        return [];
      }

      print('전체 채팅방 수: ${snapshot.docs.length}');

      // 각 채팅방과의 거리를 계산하여 반경 내의 채팅방만 필터링
      final nearbyChatrooms = snapshot.docs.map((doc) {
        final data = doc.data();
        print('채팅방 데이터: $data');
        final chatroom = ChatroomModel.fromJson({'id': doc.id, ...data});

        final distance = Geolocator.distanceBetween(
          center.latitude,
          center.longitude,
          chatroom.geopoint.latitude,
          chatroom.geopoint.longitude,
        );
        print('채팅방과의 거리: $distance meters');

        return {'chatroom': chatroom, 'distance': distance};
      }).where((item) {
        return item['distance'] as double <= radiusInKm * 1000;
      }).toList();

      print('필터링된 채팅방 수: ${nearbyChatrooms.length}');

      // 거리순으로 정렬
      nearbyChatrooms.sort((a, b) =>
          (a['distance'] as double).compareTo(b['distance'] as double));

      return nearbyChatrooms
          .map((item) => item['chatroom'] as ChatroomModel)
          .toList();
    } catch (e, stackTrace) {
      print('주변 채팅방 조회 오류: $e');
      print('스택 트레이스: $stackTrace');
      if (e is FirebaseException) {
        print('Firebase 오류 코드: ${e.code}');
        print('Firebase 오류 메시지: ${e.message}');
      }
      return [];
    }
  }
}
