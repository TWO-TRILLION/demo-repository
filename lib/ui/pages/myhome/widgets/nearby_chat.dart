import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearbyChat extends ConsumerStatefulWidget {
  const NearbyChat({super.key});

  @override
  ConsumerState<NearbyChat> createState() => _NearbyChatState();
}

class _NearbyChatState extends ConsumerState<NearbyChat> {
  int _memberCount = 0;
  Timer? _refreshTimer;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadChatInfo();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadChatInfo() async {
    try {
      final location = ref.read(locationViewModelProvider);
      print('현재 위치: $location');

      // 모든 채팅방 가져오기
      final snapshot = await firestore.collection('Chatroom').get();
      print('전체 채팅방 수: ${snapshot.docs.length}개');

      // 각 채팅방의 정보 출력
      for (var doc in snapshot.docs) {
        print('채팅방 ID: ${doc.id}');
        print('채팅방 데이터: ${doc.data()}');
      }

      // 현재 위치와 일치하는 채팅방 찾기
      final matchingDocs = snapshot.docs.where(
          (doc) => doc.id == location || doc.data()['chatroomid'] == location);

      if (matchingDocs.isNotEmpty) {
        final chatroom = matchingDocs.first.data();
        final List<dynamic> members = chatroom['member'] ?? [];
        print('찾은 채팅방 데이터: $chatroom');
        print('멤버 수: ${members.length}명');

        if (mounted) {
          setState(() {
            _memberCount = members.length;
          });
        }
      } else {
        print('채팅방을 찾을 수 없음 (위치: $location)');
        if (mounted) {
          setState(() {
            _memberCount = 0;
          });
        }
      }
    } catch (e, stackTrace) {
      print('채팅방 정보 로딩 오류: $e');
      print('스택트레이스: $stackTrace');
      if (mounted) {
        setState(() {
          _memberCount = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationViewModelProvider);

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Presenchatpage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locationState,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '참여중인 그룹원 • ${_memberCount}명',
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' 5.0'),
                  ],
                ),
                Text(
                  '채팅방 참여하기',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
