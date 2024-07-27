import 'package:assignment/controller/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  static String route = '/onBoarding';
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _onBoardingController = Get.find<OnBoardingController>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _onBoardingController.getAuth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator.adaptive(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Checking Authentication'),
            )
          ],
        ),
      ),
    );
  }
}
