import 'package:assignment/controller/on_boarding_controller.dart';
import 'package:assignment/view/screens/bottomNavigation/bottom_navigation.dart';
import 'package:assignment/view/screens/calling/voice_call.dart';
import 'package:assignment/view/screens/calling/video_call.dart';
import 'package:assignment/view/screens/followScreen.dart/followScreen.dart';
import 'package:assignment/view/screens/login/login.dart';
import 'package:assignment/view/screens/registration/registration.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../view/screens/onboarding/on_boarding.dart';

List<GetPage> appRoute = [
  GetPage(
      name: OnBoardingScreen.route,
      page: () => OnBoardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnBoardingController>(
          () => OnBoardingController(),
        );
      })),
  GetPage(
    name: LoginScreen.route,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: RegistrationScreen.route,
    page: () => RegistrationScreen(),
  ),
  GetPage(
    name: BottomNavigationScreen.route,
    page: () => BottomNavigationScreen(),
  ),
  GetPage(
    name: Followscreen.route,
    page: () => Followscreen(),
  ),
  GetPage(
    transition: Transition.downToUp,
    name: VoiceCallPage.route,
    page: () => VoiceCallPage(),
  ),
  GetPage(
    transition: Transition.downToUp,
    name: VideoCallPage.route,
    page: () => VideoCallPage(),
  ),
];
