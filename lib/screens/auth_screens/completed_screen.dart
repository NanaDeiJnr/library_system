import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/screens/main_screen/main_screen.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/images/completed.svg',
                  height: 170,
                ),
                const SizedBox(height: 25,),

                Text(
                  'Congratulations!',
                  style: GoogleFonts.workSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 10,),

                Text(
                  'Your account has been created succesfful. Please click the button below to proceed to the app.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: MainColors.greyTextColor,
                  ),
                ),

                const SizedBox(height: 25,),

                PrimaryButton(
                  title: 'Get Started',
                  backgroundColor: MainColors.primaryColor,
                  textColor: MainColors.primaryWhite,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> MainScreen(user: FirebaseAuth.instance.currentUser!)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}