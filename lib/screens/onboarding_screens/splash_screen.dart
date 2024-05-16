import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lmsystem_app/controllers/general_controller.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.find();
    generalController.initSplpashScreen();

    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/class.svg',
              height: 100,
            ),
            const SizedBox(height: 10,),


            const Text(
              'BookIt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}