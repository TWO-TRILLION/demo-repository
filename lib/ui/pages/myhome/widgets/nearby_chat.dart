import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearbyChat extends ConsumerStatefulWidget {
  const NearbyChat({super.key});

  @override
  ConsumerState<NearbyChat> createState() => _NearbyChatState();
}

class _NearbyChatState extends ConsumerState<NearbyChat> {
  int _memberCount = 0;
  String _currentLocation = '';
  Timer? _refreshTimer;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadChatInfo();
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _loadChatInfo();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadChatInfo() async {
    try {
      // 현재 위치의 채팅방 정보 가져오기
      final snapshot = await firestore
          .collection('Chatroom')
          .orderBy('updatetime', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final chatroom = snapshot.docs.first.data();
        final List<dynamic> members = chatroom['member'] ?? [];
        final String location = chatroom['chatroomid'] ?? '';

        if (mounted) {
          setState(() {
            _memberCount = members.length;
            _currentLocation = location;
          });
        }
      }
    } catch (e) {
      print('채팅방 정보 로딩 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
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
              _currentLocation.isEmpty ? '채팅방이 없습니다' : _currentLocation,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '참여중인 그룹원 • $_memberCount명',
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
