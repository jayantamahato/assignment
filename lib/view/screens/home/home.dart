import 'package:assignment/controller/auth_controller.dart';
import 'package:assignment/controller/following_controller.dart';
import 'package:assignment/controller/home_controller.dart';
import 'package:assignment/core/local_storage.dart';
import 'package:assignment/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../onboarding/on_boarding.dart';
import 'widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());
  final FollowingController _followingController =
      Get.put(FollowingController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      String uid = await LocalStorage.getUserId();

      await _authController.getUserById(uid: uid);
      await _homeController.getUsers();
    });

    super.initState();
  }

  Future _follow({required String followId}) async {
    try {
      String uid = await LocalStorage.getUserId();
      await _followingController.follow(userId: uid, followId: followId);
    } catch (e) {
      print('$e');
    }
  }

  Future _signOut() async {
    await LocalStorage.clear();
    Get.offAllNamed(OnBoardingScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 18),
            ),
            Obx(
              () => Text(
                '${_authController.userName}',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await _signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: _homeController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator()))
                  : ListView.builder(
                      itemCount: _homeController.userList.length,
                      itemBuilder: (context, index) => UserCard(
                        isFollowed: false,
                        fn: () async {
                          await _follow(
                              followId: _homeController.userList[index].id);
                        },
                        email: _homeController.userList[index].email,
                        name: _homeController.userList[index].name,
                        uid: _homeController.userList[index].id,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
