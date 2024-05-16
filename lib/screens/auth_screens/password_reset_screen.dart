import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/primary_input.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';
import 'package:lmsystem_app/utils/utils.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final AuthController authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RoundIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password',
                      style: GoogleFonts.workSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Text(
                      'Please enter you emil below. You would receive a password reset code.',
                      style: GoogleFonts.workSans(
                        color: MainColors.greyTextColor
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: PrimaryInputField(
                  hint: 'Email',
                  controller: _emailController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: PrimaryButton(
                  title: 'Send Email',
                  backgroundColor: MainColors.primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    String email = _emailController.text.trim();

                    if (email.isNotEmpty) {
                      authController.resetPassword(email);
                    } else {
                      Utils.showErrorToast('Error', 'Password reset was not successful');
                    }
                  },
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}