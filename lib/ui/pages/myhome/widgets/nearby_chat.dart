import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';

class NearbyChat extends ConsumerStatefulWidget {
  const NearbyChat({super.key});

  @override
  ConsumerState<NearbyChat> createState() => _NearbyChatState();
}

class _NearbyChatState extends ConsumerState<NearbyChat> {
  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    final locationState = ref.watch(locationViewModelProvider);

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
              locationState,
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
