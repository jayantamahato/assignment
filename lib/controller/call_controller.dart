import 'package:assignment/core/local_storage.dart';
import 'package:assignment/view/screens/calling/voice_call.dart';
import 'package:assignment/view/screens/calling/video_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallController extends GetxService {
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString callId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      userId.value = await LocalStorage.getUserId();
    });
    Future.delayed(const Duration(seconds: 2), () {
      getCallsNotificationSteam(userId: userId.value).listen((data) {
        data.isNotEmpty
            ? Get.snackbar(
                backgroundColor: Colors.white,
                icon: CircleAvatar(
                  child: Text('${data[0]['callerName']}'.split('')[0]),
                ),
                messageText: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                          icon: const Icon(
                            Icons.phone_disabled_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            callId.value = '${data[0]['callId']}';
                            await _endCall(docId: callId.value);
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: IconButton(
                            icon: '${data[0]['callType']}' == 'voice'
                                ? const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.video_call,
                                    color: Colors.white,
                                  ),
                            onPressed: () async {
                              callId.value = '${data[0]['callId']}';
                              userId.value = await LocalStorage.getUserId();
                              userName.value = await LocalStorage.getUserName();
                              await _endCall(docId: callId.value);
                              '${data[0]['callType']}' == 'voice'
                                  ? Get.toNamed(VoiceCallPage.route)
                                  : Get.toNamed(VideoCallPage.route);

                              Get.back();
                            }),
                      )
                    ],
                  ),
                ),
                ' ${data[0]['callerName']} is Calling You',
                '',
                duration: const Duration(seconds: 30))
            : null;
      });
    });
  }

  Future<void> makeVoiceCall(
      {required String callingUserName, required String callingUserID}) async {
    userId.value = await LocalStorage.getUserId();
    userName.value = callingUserName;
    callId.value = '$userId-$callingUserID';
    String callerName = await LocalStorage.getUserName();
    Map<String, dynamic> data = {
      'callerName': callerName,
      'callerId': userId.value,
      'callingUserId': callingUserID,
      'callingUserName': callingUserName,
      'callType': 'voice',
      'time': 0.0,
      'status': 'ringing',
      'createdAt': DateTime.now(),
      'callId': callId.value
    };
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(callId.value)
        .set(data);
    Get.toNamed(VoiceCallPage.route);
  }

  Future<void> makeVideoCall(
      {required String callingUserName, required String callingUserID}) async {
    userId.value = await LocalStorage.getUserId();
    userName.value = callingUserName;
    callId.value = '$userId-$callingUserID';
    String callerName = await LocalStorage.getUserName();
    Map<String, dynamic> data = {
      'callerName': callerName,
      'callerId': userId.value,
      'callingUserId': callingUserID,
      'callingUserName': callingUserName,
      'callType': 'video',
      'time': 0.0,
      'status': 'ringing',
      'createdAt': DateTime.now(),
      'callId': callId.value
    };
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(callId.value)
        .set(data);
    Get.toNamed(VideoCallPage.route);
  }

  Stream<List<Map<String, dynamic>>> getCallsNotificationSteam(
      {required String userId}) {
    return FirebaseFirestore.instance
        .collection('calls')
        .where('callingUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'ringing')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future _endCall({required String docId}) async {
    try {} catch (e) {
      print('ERROR $e');
    }
  }
}
