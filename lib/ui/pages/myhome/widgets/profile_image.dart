import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/profile.dart';

class ProfileImage extends ConsumerStatefulWidget {
  const ProfileImage({super.key});

  @override
  ConsumerState<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends ConsumerState<ProfileImage> {
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
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
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
    );
  }
}
