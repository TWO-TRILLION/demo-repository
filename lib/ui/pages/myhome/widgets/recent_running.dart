import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sprinchat_app/constant/colors.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';

class RecentRunning extends ConsumerStatefulWidget {
  const RecentRunning({super.key});

  @override
  ConsumerState<RecentRunning> createState() => _RecentRunningState();
}

class _RecentRunningState extends ConsumerState<RecentRunning> {
  final firestore = FirebaseFirestore.instance;
  double _calorie = 0;
  double _distance = 0;
  double _speed = 0;

  @override
  void initState() {
    super.initState();
    _loadRunningData();
  }

  Future<void> _loadRunningData() async {
    try {
      final userId = ref.read(userViewModelProvider);
      final userDoc = await firestore.collection('User').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final runningData = userData['runningData'];

        if (mounted) {
          setState(() {
            _calorie = (runningData['calorie'] as num).toDouble();
            _distance = (runningData['distance'] as num).toDouble();
            _speed = (runningData['speed'] as num).toDouble();
          });
        }
      }
    } catch (e) {
      print('러닝 데이터 로딩 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 시간 계산 (거리와 속도를 이용)
    String timeText = '00:00';
    if (_speed > 0) {
      final minutes = (_distance / _speed * 60).round();
      timeText =
          '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '최근 러닝',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                '${_calorie.toStringAsFixed(1)}',
                '소모한 칼로리',
                Icons.local_fire_department,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatCard(
                '${_speed.toStringAsFixed(1)}km/h',
                '달린 속도',
                Icons.speed,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatCard(
                '${_distance.toStringAsFixed(1)}km',
                '달린 거리',
                Icons.straighten,
              ),
            ),
          ],
        ),
      ],
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
          Icon(icon, color: AppColors.blueAccent),
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
