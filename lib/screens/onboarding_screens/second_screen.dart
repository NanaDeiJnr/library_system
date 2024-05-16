import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Header Section',
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                ),
          
                const Spacer(),
          
                SvgPicture.asset(
                  'assets/images/booking.svg',
                  height: 200,
                ),
          
                const Spacer(),
          
                Text(
                  'Reserve Study Spaces Effortlessly',
                  style: GoogleFonts.workSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),

                const SizedBox(height: 10,),

                Text(
                  'Welcome to our library management app! Easily reserve study rooms and resources with a few taps. Stay organized and efficient in your study sessions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: Colors.black54
                  ),
                ),

                const SizedBox(height: 30,),

                const PrimaryButton(
                  title: 'Continue',
                  textColor: Colors.white,
                  backgroundColor: MainColors.primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}