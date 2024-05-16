import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/controllers/general_controller.dart';
import 'package:lmsystem_app/firebase_options.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';
// import 'package:lmsystem_app/screens/onboarding_screens/main_onboarding_screen.dart';
import 'package:lmsystem_app/screens/onboarding_screens/splash_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(GeneralController());
  Get.put(AuthController());

  runApp(GetMaterialApp(
    theme: ThemeData(
      textTheme: GoogleFonts.workSansTextTheme()
    ),
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
  ));
}