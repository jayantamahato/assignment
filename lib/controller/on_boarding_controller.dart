import 'package:assignment/core/local_storage.dart';
import 'package:assignment/view/screens/bottomNavigation/bottom_navigation.dart';
import 'package:assignment/view/screens/login/login.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  RxBool isLoading = false.obs;

  Future getAuth() async {
    try {
      isLoading(true);
      var user = await LocalStorage.getUserId();
      if (user == '') {
        Get.offAllNamed(LoginScreen.route);
      } else {
        Get.offAllNamed(BottomNavigationScreen.route);
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading(false);
    }
  }
}
