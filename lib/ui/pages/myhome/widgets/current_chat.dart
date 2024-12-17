import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';

class CurrentChat extends ConsumerStatefulWidget {
  const CurrentChat({super.key});

  @override
  ConsumerState<CurrentChat> createState() => _CurrentChatState();
}

class _CurrentChatState extends ConsumerState<CurrentChat> {
  @override
  void initState() {
    super.initState();
    _loadLastChatRoom();
  }

  Future<void> _loadLastChatRoom() async {
    try {
      final userRepo = UserRepository();
      final userId = ref.read(userViewModelProvider);
      final user = await userRepo.getOne(userId);

      if (user != null && user.lastChatRoomId?.isNotEmpty == true) {
        final chatViewModel = ref.read(chatViewModelProvider.notifier);
        chatViewModel.setUserId(userId);
        chatViewModel.setLocation(user.lastChatRoomId!);
        await chatViewModel.readChats();
      }
    } catch (e) {
      print('마지막 채팅방 로딩 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);

    if (chatState.location.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            '참여중인 채팅방이 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chatState.location.isEmpty ? '참여중인 채팅방이 없습니다' : chatState.location,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            '참여중인 그룹원 • ${chatState.chats.member.length}명',
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
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on UserModel {
  get lastChatRoomId => null;
}
