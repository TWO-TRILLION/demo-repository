import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/background.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/bottomwindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/fruit.dart';
import 'package:flutter_sprinchat_app/ui/pages/presenchatpage/widgets/hill.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';

class Presenchatpage extends ConsumerStatefulWidget {
  const Presenchatpage({super.key});

  @override
  ConsumerState<Presenchatpage> createState() => _PresenchatpageState();
}

class _PresenchatpageState extends ConsumerState<Presenchatpage> {
  @override
  void initState() {
    ref.read(chatViewModelProvider.notifier).readChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chatState = ref.watch(chatViewModelProvider);
    int membersNum = chatState.chats.member.length;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          Background(membersNum: membersNum),
          Hill(),
          Fruit(membersNum: membersNum),
          Bottomwindow(),
        ],
      )),
      bottomNavigationBar: const CustomNavigationBar(currentPage: 'chat'),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
    ;
  }
}
