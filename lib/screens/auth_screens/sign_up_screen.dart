// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names, unused_element, unused_field
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/phone_number_input_field.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/primary_input.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/components/secondary_input_field.dart';
import 'package:lmsystem_app/screens/auth_screens/login_screen.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: MainColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
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
            
                const SizedBox(height: 15,),
            
                // Title and sub title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up!',
                        style: GoogleFonts.workSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                        ),
                      ),
            
                      const SizedBox(height: 5,),
            
                      Text(
                        'Fill the form to create an account',
                        style: GoogleFonts.workSans(
                          color: Colors.black54,
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 30,),
            
                      // Student's name
                      Row(
                        children: [
                          SecondaryInputField(
                            controller: firstnameController,
                            hint: 'Firstname',
                            validator: (text){
                              if(text == null || text.isEmpty){
                                return "Required";
                              }else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(width: 5,),
            
                          SecondaryInputField(
                            hint: 'Lastname',
                            controller: lastnameController,
                            validator: (text){
                              if(text == null || text.isEmpty){
                                return "Required";
                              }else{
                                return null;
                              }
                            },
                          )
                        ],
                      ),
            
                      // Email
                      PrimaryInputField(
                        hint: 'Email',
                        controller: emailController,
                        validator: (text) {
                          if(text == null || text.isEmpty){
                            return "Required";
                          }else if(!GetUtils.isEmail(text)){
                            return 'Enter a valid email';
                          }else{
                            return null;
                          }
                        },
                      ),
            
                      const SizedBox(height: 16,),
            
                      // Student ID
                      PrimaryInputField(
                        hint: 'Student ID',
                        controller: studentIdController,
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return "Required";
                          }else{
                            return null;
                          }
                        },
                      ),
            
                      const SizedBox(height: 16,),
            
                      // Phone Number
                      PhoneNumberInputField(
                        controller: phoneNumberController,
                      ),
            
                      const SizedBox(height: 16,),
                      // Password
                      PrimaryInputField(
                        hint: 'Password',
                        obscureText: true,
                        controller: passwordController,
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return "Required";
                          }else{
                            return null;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {
                            // Button on pressed 
                          },
                        ),
                      ),
                      const SizedBox(height: 30,),
            
                      PrimaryButton(
                        title: 'Register',
                        backgroundColor: MainColors.primaryColor,
                        textColor: MainColors.primaryWhite,
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            String firstName = firstnameController.text;
                            String lastName = lastnameController.text;
                            String email = emailController.text;
                            String student_id = studentIdController.text;
                            String phone_number = phoneNumberController.text;
                            String password = passwordController.text;
              
                            print('student_id: $student_id');
              
                            authController.registerUser(firstName, lastName, email, student_id, phone_number , password);
                          }
                        }
                      ),
            
                      const SizedBox(height: 12,),
            
                      Row(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style: GoogleFonts.workSans(
                                    // fontWeight: FontWeight.bold,
                                    // color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Login!',
                                  style: GoogleFonts.workSans(
                                    // fontStyle: FontStyle.italic,
                                    color: MainColors.secondaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    //Navigate to Sign Up Screen
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const LoginScreen()));
                                  }
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}