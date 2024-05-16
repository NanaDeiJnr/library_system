// ignore_for_file: avoid_print, unused_import, unused_element

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lmsystem_app/screens/auth_screens/login_screen.dart';
import 'package:lmsystem_app/screens/main_screen/main_screen.dart';
import 'package:lmsystem_app/screens/onboarding_screens/main_onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralController extends GetxController{
  
  void initSplpashScreen(){
    Timer(const Duration(seconds: 3), () {
      final authUser = FirebaseAuth.instance.currentUser;

      if(authUser == null){
        Get.offAll(()=> const MainOnboardingScreen());
      }else{
        Get.offAll(()=> MainScreen(user: FirebaseAuth.instance.currentUser!));
      }
    });
  }

  void _navigateToScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
    if (isFirstLaunch) {
      // First launch, navigate to onboarding screen
      Get.offAll(() => const MainOnboardingScreen());
      prefs.setBool('first_launch', false);
    } else {
      // Subsequent launch, navigate to main screen
      Get.offAll(() => MainScreen(user: FirebaseAuth.instance.currentUser!));
    }
  }
}
