import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/location_viewmodel/location_viewmodel.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/user_viewmodel/user_viewmodel.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/widgets/chatswindow.dart';
import 'package:flutter_sprinchat_app/ui/pages/chatpage/widgets/inputmessage.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';

class Chatpage extends ConsumerStatefulWidget {
  const Chatpage({super.key});

  @override
  ConsumerState<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends ConsumerState<Chatpage> {
  @override
  void initState() {
    final location = ref.read(locationViewModelProvider);
    final userid = ref.read(userViewModelProvider);
    // 위치세팅(chatroomid)
    ref.read(chatViewModelProvider.notifier).setLocation(location);
    // 유저세팅(userid)
    ref.read(chatViewModelProvider.notifier).setUserId(userid);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatViewModelProvider.notifier).scrollEndPosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chatState = ref.watch(chatViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${chatState.location}'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: Column(
          children: [
            // 채팅창
            Chatswindow(
              chatState: chatState,
              scrollController: chatState.scrollController,
            ),
            // 입력필드
            Inputmessage(scrollController: chatState.scrollController),
          ],
        )),
      ),
    );
  }
}
