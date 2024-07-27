import 'package:assignment/core/local_storage.dart';
import 'package:assignment/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  RxBool isLoading = false.obs;
  RxList myFollowers = [].obs;
  RxList requestList = [].obs;
  RxList userList = [].obs;
  RxList friendList = [].obs;

  //get all users

  Future getAllUsers() async {
    try {
      String uid = await LocalStorage.getUserId();
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
    }
  }

//Follow an user

  Future follow({required String userId, required String followId}) async {
    try {
      isLoading(true);
      // Update the document with the new data
      String docId = '$followId-$userId';
      Map<String, dynamic> data = {
        'userId': userId,
        'follow': followId,
        'enableCall': false,
      };
      await FirebaseFirestore.instance
          .collection('follow')
          .doc(docId)
          .set(data);

      await getMyFollowers();
      print('Follow success');
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  //Get my followers

  Future getMyFollowers() async {
    try {
      isLoading(true);
      await getAllUsers();
      myFollowers.clear();
      String uid = await LocalStorage.getUserId();

      var followers = await FirebaseFirestore.instance
          .collection('follow')
          .where('follow', isEqualTo: uid)
          .where('enableCall', isEqualTo: false)
          .get();
      if (followers.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in followers.docs) {
          // Ensure doc.data() is a Map<String, dynamic>
          var data = doc.data() as Map<String, dynamic>;

          myFollowers.assignAll(
              userList.where((item) => item.id == data['userId']).toList());
        }
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

//check if user already Follow

  Future checkFollow({required String followId}) async {
    try {
      String uid = await LocalStorage.getUserId();
      var user = await FirebaseFirestore.instance
          .collection('follow')
          .where('follow', isEqualTo: followId)
          .where('userId', isEqualTo: uid)
          .get();
      for (QueryDocumentSnapshot doc in user.docs) {
        print('User data: ${doc.data()}');
      }
    } catch (e) {}
  }

//get my request

  Future getSendRequest() async {
    try {
      isLoading(true);
      await getAllUsers();

      requestList.clear();
      String uid = await LocalStorage.getUserId();
      var followers = await FirebaseFirestore.instance
          .collection('follow')
          .where('userId', isEqualTo: uid)
          .where(
            'enableCall',
            isEqualTo: false,
          )
          .get();
      if (followers.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in followers.docs) {
          // Ensure doc.data() is a Map<String, dynamic>
          var data = doc.data() as Map<String, dynamic>;

          requestList.assignAll(
              userList.where((item) => item.id == data['follow']).toList());
        }
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading(false);
    }
  }

  Future followBack({required String followId}) async {
    try {
      isLoading(true);

      String userId = await LocalStorage.getUserId();

      String docId = '$userId-$followId';

      // Update the document with the new data
      docId = '$followId-$userId';
      Map<String, dynamic> updatedData = {
        'userId': followId,
        'follow': userId,
        'enableCall': true,
      };
      await FirebaseFirestore.instance
          .collection('follow')
          .doc(docId)
          .update(updatedData);

      await getMyFollowers();
      print('User data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  Future getMyFriend() async {
    try {
      print("calling");
      isLoading(true);
      await getAllUsers();

      requestList.clear();
      String uid = await LocalStorage.getUserId();
      var followers = await FirebaseFirestore.instance
          .collection('follow')
          .where('userId', isEqualTo: uid)
          .where(
            'enableCall',
            isEqualTo: true,
          )
          .get();
      for (QueryDocumentSnapshot doc in followers.docs) {
        // Ensure doc.data() is a Map<String, dynamic>
        var data = doc.data() as Map<String, dynamic>;
        print('$data');
        friendList.assignAll(
            userList.where((item) => item.id == data['follow']).toList());

        print('$friendList');
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading(false);
    }
  }
}
