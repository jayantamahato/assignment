import 'package:assignment/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/friend_card.dart';

class CallsScreen extends StatefulWidget {
  static String route = '/calling';
  CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  FollowingController _followingController = Get.put(FollowingController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _followingController.getMyFriend();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calls'),
      ),
      body: Obx(
        () => _followingController.isLoading.isTrue
            ? const Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _followingController.friendList.length,
                      itemBuilder: (context, index) => FriendCard(
                        id: _followingController.friendList[index].id,
                        name: _followingController.friendList[index].name,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
