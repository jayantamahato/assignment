import 'package:assignment/core/local_storage.dart';
import 'package:assignment/model/user_model.dart';
import 'package:assignment/view/screens/bottomNavigation/bottom_navigation.dart';
import 'package:assignment/view/screens/registration/registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxString userName = ''.obs;

  //login

  Future login({
    required String email,
  }) async {
    try {
      print(email);
      isLoading(true);
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (user.docs.isEmpty) {
        Get.toNamed(RegistrationScreen.route);
      } else {
        LocalStorage.setUserId(uid: user.docs[0].id);
        Get.offAllNamed(BottomNavigationScreen.route);
      }
    } catch (e) {
      print('ERROR:  ${e}');
    } finally {
      isLoading(false);
    }
  }
  //reg

  Future registration({required UserModel user}) async {
    try {
      isLoading(true);
      var res = await FirebaseFirestore.instance
          .collection('users')
          .add(user.toJson());
      LocalStorage.setUserId(uid: res.id);
      const SnackBar(content: const Text('Account Created!'));
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(BottomNavigationScreen.route);
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future getUserById({required String uid}) async {
    try {
      // Retrieve the document snapshot from Firestore
      DocumentSnapshot res =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (res.exists) {
        Map<String, dynamic> data = res.data() as Map<String, dynamic>;
        userName(data['name']);
        await LocalStorage.setUserName(name: userName.value);
      } else {
        print('No user found with UID: $uid');
      }
    } catch (e) {
      rethrow;
    }
  }
}
