import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/firebase_options.dart';
import 'package:flutter_sprinchat_app/ui/pages/login/login_page.dart';
import 'package:flutter_sprinchat_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase 초기화 성공');
  } catch (e) {
    print('Firebase 초기화 오류: $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SprinChat',
      home: SplashScreen(),
      theme: theme,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _colorAnimation =
        ColorTween(begin: Colors.white, end: Colors.white).animate(_controller);
    _controller.forward();

    // 초기화 작업 (예: 데이터 로딩, 로그인 등)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorAnimation.value,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Image.asset('assets/images/appicon.png'),
          ),
        ),
      ),
    );
  }
}
