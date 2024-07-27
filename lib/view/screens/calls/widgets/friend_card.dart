import 'package:assignment/controller/call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendCard extends StatelessWidget {
  final String name;
  final String id;
  FriendCard({super.key, required this.name, required this.id});
  final CallController _callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name.split('')[0]),
      ),
      title: Text(name),
      trailing: SizedBox(
        width: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                _callController.makeVideoCall(
                    callingUserName: name, callingUserID: id);
              },
              child: CircleAvatar(
                backgroundColor: Colors.green.shade200,
                child: const Icon(
                  Icons.video_call,
                  size: 15,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                _callController.makeVoiceCall(
                    callingUserName: name, callingUserID: id);
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade200,
                child: const Icon(
                  Icons.phone,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
