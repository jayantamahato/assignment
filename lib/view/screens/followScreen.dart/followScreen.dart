import 'package:assignment/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/follower.dart';
import 'widgets/request.dart';

class Followscreen extends StatefulWidget {
  static String route = '/follow';
  Followscreen({super.key});

  @override
  State<Followscreen> createState() => _FollowscreenState();
}

class _FollowscreenState extends State<Followscreen> {
  FollowingController _followingController = Get.put(FollowingController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _followingController.getMyFollowers();
      await _followingController.getSendRequest();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Follower'),
            bottom: const TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
              Tab(
                icon: Icon(Icons.arrow_downward_rounded),
                text: 'Follow Request',
              ),
              Tab(
                icon: Icon(Icons.arrow_upward_rounded),
                text: 'Send Request',
              ),
            ]),
          ),
          body: TabBarView(
            children: [MyFollower(), SendRequest()],
          )),
    );
  }
}
