import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_page.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentPage;

  const CustomNavigationBar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.all(16),
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
                      builder: (context) => const Presenchatpage()),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
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
    );
  }
}
