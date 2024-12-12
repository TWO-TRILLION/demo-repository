import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/data/repository/chatrepository.dart';
import 'package:flutter_sprinchat_app/firebase_options.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/my_home.dart';
import 'package:flutter_sprinchat_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));

 /*
  final chatrepo = Chatrepository();
  final chatmodel = await chatrepo.get('부산 광역시 동래구 온천동');

  print(chatmodel[0].chatroomid);
  print(chatmodel[0].updatetime);
  print(chatmodel[0].chats[0]['message']);
  print(chatmodel[0].member[0]);
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHome(),
      theme: theme,
    );
  }
}
