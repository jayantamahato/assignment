import 'package:assignment/controller/call_controller.dart';
import 'package:assignment/core/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatefulWidget {
  static String route = '/video-call';
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  CallController _callController = Get.put(CallController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppKeys.zego_app_id,
      appSign: AppKeys.zego_app_sign,
      userID: _callController.userId.value,
      userName: _callController.userName.value,
      callID: _callController.callId.value,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
