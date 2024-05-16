// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/primary_input.dart';
import 'package:lmsystem_app/components/secondary_button.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';
import 'package:lmsystem_app/screens/auth_screens/password_reset_screen.dart';
import 'package:lmsystem_app/screens/auth_screens/sign_up_screen.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const Row(
                children: [
                  
                ],
              ),

              const SizedBox(height: 15,),

              // Title and sub title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.workSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Text(
                      'Fill the form to login',
                      style: GoogleFonts.workSans(
                        color: Colors.black54,
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 30,),

                    PrimaryInputField(
                      hint: 'Email',
                      controller: emailController,
                    ),

                    const SizedBox(height: 16,),

                    PrimaryInputField(
                      hint: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: () {
                          // Button on pressed 
                        },
                      ),
                    ),
                    const SizedBox(height: 5,),

                    // Password Reset button
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> const PasswordResetScreen()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.workSans(
                          color: MainColors.secondaryColor
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    PrimaryButton(
                      title: 'Login',
                      backgroundColor: MainColors.primaryColor,
                      textColor: MainColors.primaryWhite,
                      onTap: () {
                        //Login Function
                        authController.login(email: emailController.text.trim(), password:passwordController.text);
                      },
                    ),

                    const SizedBox(height: 15,),

                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: GoogleFonts.workSans(
                                  
                                ),
                              ),
                              TextSpan(
                                text: 'Click Here!',
                                style: GoogleFonts.workSans(
                                  // fontStyle: FontStyle.italic,
                                  color: MainColors.secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  //Navigate to Sign Up Screen
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const SignUpScreen()));
                                }
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    const Divider(thickness: 1,),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Or Login with',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.workSans(
                            color: MainColors.greyTextColor
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                    SecondaryButton(
                      title: 'Login with Google',
                      image: 'assets/images/google.png',
                      borderColor: Colors.black54,
                      onTap: () async{
                        //OAuth with Google
                      },
                    ),

                    const SizedBox(height: 15,),

                    SecondaryButton(
                      title: 'Login with Apple',
                      image: 'assets/images/apple-logo.png',
                      borderColor: Colors.black54,
                      onTap: () {
                        //OAuth with Apple
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}