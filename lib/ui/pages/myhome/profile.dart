import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/login/login_page.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/model/user_model.dart';
import 'package:flutter_sprinchat_app/data/repository/user_repository.dart';
import 'package:flutter_sprinchat_app/ui/widgets/nickname_text_form_field.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final ImagePicker _picker = ImagePicker();
  final String defaultProfileImage = 'assets/images/default_profile.png';
  bool _isEditing = false;
  late TextEditingController _nameController;
  UserModel? _userModel;
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final userId = ref.read(userViewModelProvider); // 실제 사용자 ID 사용
    final userRepo = ref.read(userRepositoryProvider);
    final user = await userRepo.getOne(userId);

    if (user != null) {
      setState(() {
        _userModel = user;
        _nameController.text = user.nickname;
        // 이미지 URL이 있으면 선택된 이미지로 설정
        if (user.imageUrl != null && user.imageUrl!.isNotEmpty) {
          _selectedImagePath = user.imageUrl;
        }
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      if (_userModel == null) return;

      final userRepo = ref.read(userRepositoryProvider);

      // 닉네임 업데이트
      await userRepo.updateNickname(_userModel!.userid, _nameController.text);

      // 이미지가 선택되었다면 이미지도 업데이트
      if (_selectedImagePath != null &&
          !_selectedImagePath!.startsWith('http')) {
        await userRepo.updateUserImage(_userModel!.userid, _selectedImagePath!);
      }

      // 프로필 다시 로드
      await _loadUserProfile();

      setState(() {
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('프로필이 업데이트되었습니다.')),
        );
        // 프로필 수정 완료 후 이전 화면으로 돌아가기
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHome()),
        );
      }
    } catch (e) {
      print('프로필 저장 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('프로필 저장 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });
      }
    } catch (e) {
      print('이미지 선택 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 프로필 이미지 위젯
    Widget profileImage = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        image: DecorationImage(
          image: _selectedImagePath != null
              ? (_selectedImagePath!.startsWith('http')
                  ? NetworkImage(_selectedImagePath!)
                  : FileImage(File(_selectedImagePath!)) as ImageProvider)
              : AssetImage(defaultProfileImage),
          fit: BoxFit.cover,
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        if (_isEditing) {
          setState(() {
            _isEditing = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 배경 이미지
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _selectedImagePath != null
                      ? (_selectedImagePath!.startsWith('http')
                          ? NetworkImage(_selectedImagePath!)
                          : FileImage(File(_selectedImagePath!))
                              as ImageProvider)
                      : AssetImage(defaultProfileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 배경 오버레이
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            // 컨텐츠
            SafeArea(
              child: Column(
                children: [
                  // 상단 네비게이션 바
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 20),
                          onPressed: () {
                            if (_isEditing) {
                              setState(() {
                                _isEditing = false;
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        if (_isEditing)
                          TextButton(
                            onPressed: () async {
                              await _saveProfile();
                              setState(() {
                                _isEditing = false;
                              });
                            },
                            child: const Text(
                              '완료',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // 프로필 이미지
                  GestureDetector(
                    onTap: _isEditing ? _pickImage : null,
                    child: Stack(
                      children: [
                        profileImage,
                        if (_isEditing)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 사용자 이름
                  if (_isEditing)
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: NicknameTextFormField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    Text(
                      _nameController.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                  const Spacer(flex: 2),

                  // 프로필 수정 버튼
                  if (!_isEditing)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(140, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        '프로필 수정',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  // 로그아웃 버튼 - 수정 모드가 아닐 때만 표시
                  if (!_isEditing)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
