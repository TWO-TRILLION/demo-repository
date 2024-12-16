import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/profile.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/home_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});

  @override
  ConsumerState<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  DecorationImage? _profileImage;
  final String defaultProfileImage = 'assets/images/default_profile.png';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      final userRepo = UserRepository();
      final userId = ref.read(userViewModelProvider);
      final user = await userRepo.getOne(userId);

      if (mounted) {
        setState(() {
          if (user != null &&
              user.imageUrl != null &&
              user.imageUrl!.isNotEmpty) {
            _profileImage = DecorationImage(
              image: NetworkImage(user.imageUrl!),
              fit: BoxFit.cover,
              onError: (error, stackTrace) {
                setState(() {
                  _profileImage = DecorationImage(
                    image: AssetImage(defaultProfileImage),
                    fit: BoxFit.cover,
                  );
                });
              },
            );
          } else {
            _profileImage = DecorationImage(
              image: AssetImage(defaultProfileImage),
              fit: BoxFit.cover,
            );
          }
        });
      }
    } catch (e) {
      print('프로필 이미지 로딩 오류: $e');
      if (mounted) {
        setState(() {
          _profileImage = DecorationImage(
            image: AssetImage(defaultProfileImage),
            fit: BoxFit.cover,
          );
        });
      }
    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HomeLocation(onLocationChanged: (location) {}),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                      if (mounted) {
                        await _loadProfileImage();
                      }
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
              const Text(
                '최근 러닝',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
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
      bottomNavigationBar: CustomNavigationBar(
        currentPage: 'home',
        currentLocation: '부산광역시 동래구 온천동',
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
}
