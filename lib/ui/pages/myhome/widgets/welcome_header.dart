import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';

class WelcomeHeader extends ConsumerStatefulWidget {
  const WelcomeHeader({super.key});

  @override
  ConsumerState<WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends ConsumerState<WelcomeHeader> {
  String? _nickname;

  @override
  void initState() {
    super.initState();
    _loadNickname();
  }

  Future<void> _loadNickname() async {
    try {
      final userRepo = UserRepository();
      final userId = ref.read(userViewModelProvider);
      final user = await userRepo.getOne(userId);

      if (mounted && user != null) {
        setState(() {
          _nickname = user.nickname;
        });
      }
    } catch (e) {
      print('닉네임 로딩 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _nickname != null
        ? RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: '어서오세요 '),
                TextSpan(
                  text: _nickname,
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                ),
                const TextSpan(text: '님'),
              ],
            ),
          )
        : const Text(
            '로딩중...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
