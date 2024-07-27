import 'package:assignment/controller/following_controller.dart';
import 'package:assignment/core/local_storage.dart';
import 'package:assignment/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList userList = [].obs;
  FollowingController _followercontroller = Get.put(FollowingController());

  //get all users

  Future getUsers() async {
    try {
      isLoading(true);
      String uid = await LocalStorage.getUserId();
      _followercontroller.getMyFollowers();
      userList.clear();

      var users = await FirebaseFirestore.instance.collection('users').get();
      for (QueryDocumentSnapshot doc in users.docs) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        if (doc.id != uid) {
          userList.add(UserModel.fromJson(data));
        }
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading(false);
    }
  }
}
