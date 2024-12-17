import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sprinchat_app/ui/widgets/navigation_bar.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/home_location.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/current_chat.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/welcome_header.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/profile_image.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/recent_running.dart';
import 'package:flutter_sprinchat_app/ui/pages/myhome/widgets/nearby_chat.dart';

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});

  @override
  ConsumerState<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const WelcomeHeader(),
                          HomeLocation(onLocationChanged: (location) {}),
                        ],
                      ),
                    ),
                    const ProfileImage(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '진행중인 채팅',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const CurrentChat(),
                const SizedBox(height: 20),
                const Text(
                  '내 근처 채팅',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const NearbyChat(),
                const SizedBox(height: 20),
                const RecentRunning(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentPage: 'home',
      ),
    );
  }
}
