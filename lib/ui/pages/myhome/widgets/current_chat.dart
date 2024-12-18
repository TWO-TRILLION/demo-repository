import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/constant/colors.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/chatpage.dart';

class CurrentChat extends ConsumerStatefulWidget {
  const CurrentChat({super.key});

  @override
  ConsumerState<CurrentChat> createState() => _CurrentChatState();
}

class _CurrentChatState extends ConsumerState<CurrentChat> {
  String _currentLocation = '';
  String _lastChatRoomId = '';
  int _memberCount = 0;
  Timer? _refreshTimer;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadLastChatRoom();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadLastChatRoom() async {
    try {
      final userId = ref.read(userViewModelProvider);
      final userDoc = await firestore.collection('User').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final lastChatRoomId = userData['lastchatroomid'] as String?;

        if (lastChatRoomId?.isNotEmpty == true) {
          final chatDoc =
              await firestore.collection('Chatroom').doc(lastChatRoomId).get();

          if (chatDoc.exists) {
            final chatData = chatDoc.data()!;
            final List<dynamic> members = chatData['member'] ?? [];

            if (mounted) {
              setState(() {
                _currentLocation = lastChatRoomId ?? '';
                _lastChatRoomId = lastChatRoomId ?? '';
                _memberCount = members.length;
              });
            }
          }
        } else {
          if (mounted) {
            setState(() {
              _currentLocation = '';
              _lastChatRoomId = '';
              _memberCount = 0;
            });
          }
        }
      }
    } catch (e) {
      print('마지막 채팅방 로딩 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatpage(_lastChatRoomId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: _currentLocation.isEmpty
            ? const Center(
                child: Text(
                  '참여중인 채팅방이 없습니다',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _lastChatRoomId,
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
                        '현재 위치 기준',
                        style: const TextStyle(
                          color: AppColors.blueAccent,
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

extension on UserModel {
  get lastChatRoomId => null;
}
