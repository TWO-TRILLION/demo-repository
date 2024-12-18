import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 러닝 중일 경우 화면 하단에 띄울 기능 없는 컨테이너
// 클릭해도 다른 페이지로 이동하지 않습니다
class UnavailableNavigationbar extends ConsumerWidget {
  final String currentPage;

  const UnavailableNavigationbar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 206, 206),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            unavailableNavItem(
              icon: Icons.home_filled,
              label: 'Home',
              isSelected: currentPage == 'home',
            ),
            unavailableNavItem(
              icon: Icons.chat_bubble,
              label: 'Chat',
              isSelected: currentPage == 'chat',
            ),
            unavailableNavItem(
              icon: Icons.directions_run,
              label: 'Running',
              isSelected: currentPage == 'running',
            ),
          ],
        ),
      ),
    );
  }

  // 네비게이션 바 아이템 빌드
  Widget unavailableNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color.fromARGB(255, 90, 90, 90),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color.fromARGB(255, 219, 219, 219)
                  : Colors.grey,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
