import 'package:assignment/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFollower extends StatelessWidget {
  MyFollower({super.key});
  FollowingController _followingController = Get.put(FollowingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _followingController.isLoading.value
          ? const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: _followingController.myFollowers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _followingController.myFollowers.length,
                      itemBuilder: (context, index) => ListTile(
                        title:
                            Text(_followingController.myFollowers[index].name),
                        subtitle:
                            Text(_followingController.myFollowers[index].email),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () async {
                              await _followingController.followBack(
                                  followId: _followingController
                                      .myFollowers[index].id);
                            },
                            child: const Text(
                              'Follow Back',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("Don't have any followers yet"),
                    ),
            ),
    );
  }
}
