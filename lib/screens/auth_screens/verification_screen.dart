// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String studentId;
  final String phone_number;
  final String? email;
  const VerificationScreen({super.key, required this.studentId, required this.phone_number, this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  Future<void> fetchAndDisplayOTP(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://f758ac26213bf92ff469e1b05511db06.serveo.net/generate_otp'),
        body: {
          'student_id': widget.studentId,
          'email': widget.email,
          'phone_number': widget.phone_number,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final otp = jsonDecode(response.body)['otp'] as String;
        print(otp);

        ElegantNotification(
          title: const Text('Your OTP is'),
          description: Text(otp),
          toastDuration: const Duration(minutes: 2),
          icon: null
        ).show(context);
        // Display the OTP in your app
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch OTP')));
      }
    } catch (error) {
      print('Error fetching OTP: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching OTP')));
    }
  }



  Future<void> verifyOtp() async{
    final String otp = otpController.text;

    final Map<String, String> requestBody = {
      'otp' : otp,
      'student_id' : widget.studentId
    };

    final Uri verifyOtpUri = Uri.parse('https://9a425afdceaecf2d938c446b41bbde12.serveo.net/verify_otp_view');

    try{
      final response = await http.post(verifyOtpUri, body: requestBody);

      if (response.statusCode == 200){
        print('OTP verification successful');
      }else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('OTP Verification failed: ${responseData['error']}');
      }
    } catch (error){
      print('Error verifying OTP: $error');

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  RoundIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
          
              const SizedBox(height: 30,),
              Column(
                children: [
                  Text(
                    'Verify Your Account',
                    style: GoogleFonts.workSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'A verification code has been sent to your number. Enter the code to verify',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      color: MainColors.greyTextColor
                    ),
                  ),
          
                  const SizedBox(height: 10,),
                  Text(
                    widget.phone_number,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
          
              const SizedBox(height: 20,),
          
              PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 50,
                  fieldWidth: 50,
                ),
                animationDuration: const Duration(milliseconds: 300),
                controller: otpController,
                onCompleted: (value) {
                  print('Completed');
                },

                onChanged: (value){
                  
                },
              ),
          
              const SizedBox(height: 30,),
          
              Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have\'t received your code? ',
                          style: GoogleFonts.workSans(

                          ),
                        ),
                        TextSpan(
                          text: 'Resend code',
                          style: GoogleFonts.workSans(
                            color: MainColors.secondaryColor,
                            fontWeight: FontWeight.w500
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            //Navigate to Sign Up Screen
                            // Navigator.push(context, MaterialPageRoute(builder: (_)=> const MainScreen()));
                          }
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          
              const SizedBox(height: 30,),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    title: 'Verify OTP',
                    backgroundColor: MainColors.primaryColor,
                    textColor: MainColors.primaryWhite,
                    onTap: verifyOtp,
                  ),
                ],
              )
                
            ],
          ),
        ),
      ),
    );
  }
}
