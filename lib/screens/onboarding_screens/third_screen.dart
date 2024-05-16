import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
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
                  'Simplify Your Library Experience',
                  style: GoogleFonts.workSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),

                const SizedBox(height: 10,),

                Text(
                  'Simplify your library experience with our user-friendly interface. Navigate effortlessly, discover resources quickly, and manage your bookings with ease. Enjoy a hassle-free library experience!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: Colors.black54
                  ),
                ),

                const SizedBox(height: 30,),

                const PrimaryButton(
                  title: 'Get Started',
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