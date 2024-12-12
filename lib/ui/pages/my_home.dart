import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/profile.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  DecorationImage? _profileImage;
  final String defaultProfileImage = 'assets/images/default_profile.png';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final profileImagePath = prefs.getString('profile_image');
    setState(() {
      if (profileImagePath != null) {
        _profileImage = DecorationImage(
          image: FileImage(File(profileImagePath)),
          fit: BoxFit.cover,
        );
      } else {
        _profileImage = DecorationImage(
          image: AssetImage(defaultProfileImage),
          fit: BoxFit.cover,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          Text(
                            '서울시 강남구 삼성동',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      ).then((_) => _loadProfileImage());
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 2),
                        image: _profileImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 진행중인 채팅 카드
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '진행중인 채팅',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '부산광역시 동래구 온천동',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '참여중인 그룹원 • 10명',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' 5.0'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 최근 러닝 섹션
              const Text(
                '최근 러닝',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // 통계 카드들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(
                      '3,950', 'Cal Burnt', Icons.local_fire_department),
                  _buildStatCard('3h 14min', 'Total Time', Icons.access_time),
                  _buildStatCard('15', 'Exercises', Icons.fitness_center),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_filled, true),
            _buildNavItem(Icons.person_outline, false),
            _buildNavItem(Icons.history, false),
            _buildNavItem(Icons.arrow_forward_ios, false),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      child: Icon(
        icon,
        color: isSelected ? Colors.black : Colors.white,
        size: 20,
      ),
    );
  }
}
