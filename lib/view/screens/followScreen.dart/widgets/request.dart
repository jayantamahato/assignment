import 'package:assignment/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendRequest extends StatelessWidget {
  SendRequest({super.key});
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
          : _followingController.requestList.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView.builder(
                    itemCount: _followingController.requestList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_followingController.requestList[index].name),
                      subtitle:
                          Text(_followingController.requestList[index].email),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Requested',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text("You don't have send any request yet"),
                ),
    );
  }
}
