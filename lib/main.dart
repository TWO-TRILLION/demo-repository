import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/firebase_options.dart';
import 'package:flutter_sprinchat_app/ui/pages/my_home.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/presenchatpage.dart';
import 'package:flutter_sprinchat_app/theme.dart';
import 'package:flutter_sprinchat_app/ui/pages/running/running_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // RunningPage 호출용 예시 좌표입니다
  // bottomNavigationBar 기능 완성한 뒤 삭제하겠습니다
  final double lat = 35.8245542;
  final double lng = 127.1007766;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const Presenchatpage(),
      theme: theme,
      /* home: RunningPage(
        startLat: lat,
        startLng: lng,
      ),*/
    );
  }
}
