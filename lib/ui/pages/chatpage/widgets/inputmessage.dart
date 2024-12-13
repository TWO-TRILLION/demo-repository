import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/core/viewmodel/chat_viewmodel/chat_viewmodel.dart';

class Inputmessage extends ConsumerStatefulWidget {
  const Inputmessage({super.key});

  @override
  ConsumerState<Inputmessage> createState() => _InputmessageState();
}

class _InputmessageState extends ConsumerState<Inputmessage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  String? inputvalidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20, left: 24, right: 24),
      child: Form(
        key: formkey,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textController,
                  validator: inputvalidator,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder()),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final bool isValid = formkey.currentState?.validate() ?? false;
                if(!isValid){
                  return;
                }
                ref.read(chatViewModelProvider.notifier).newChat("ABCD", textController.text);
                textController.text = '';
              },
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(0xff303437)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
