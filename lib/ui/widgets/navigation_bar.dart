import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';

class CustomNavigationBar extends ConsumerWidget {
  final String currentPage;

  const CustomNavigationBar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationViewModelProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          _buildNavItem(
            context: context,
            icon: Icons.home_filled,
            label: 'Home',
            isSelected: currentPage == 'home',
            onTap: () {
              if (currentPage != 'home') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHome()),
                );
              }
            },
          ),
          _buildNavItem(
            context: context,
            icon: Icons.chat_bubble,
            label: 'Chat',
            isSelected: currentPage == 'chat',
            onTap: () {
              if (currentPage != 'chat') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Presenchatpage(),
                  ),
                );
              }
            },
          ),
          _buildNavItem(
            context: context,
            icon: Icons.directions_run,
            label: 'Running',
            isSelected: currentPage == 'running',
            onTap: () {
              if (currentPage != 'running') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RunningPage(
                      startLat: 35.8245542,
                      startLng: 127.1007766,
                      currentLocation: location,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
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
      ),
    );
  }
}
