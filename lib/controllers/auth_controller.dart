// ignore_for_file: unused_element, avoid_print, non_constant_identifier_names, body_might_complete_normally_nullable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lmsystem_app/controllers/general_controller.dart';
import 'package:lmsystem_app/screens/auth_screens/completed_screen.dart';
import 'package:lmsystem_app/screens/auth_screens/login_screen.dart';
import 'package:lmsystem_app/utils/utils.dart';


class AuthController extends GetxController{


  Rx<Country?> userCountry = Rx(CountryPickerUtils.getCountryByIsoCode('GH'));
  Rx<Widget?> countryFlag = Rx(CountryPickerUtils.getDefaultFlagImage(CountryPickerUtils.getCountryByIsoCode('GH')));
  RxBool isOtpSent = RxBool(false);
  RxBool canResendOtp = RxBool(false);
  RxString phoneNumber = RxString('');
  RxString otpCode = RxString('');

  RxString otpVerificationId = RxString('');
  Rx<int?> otpResendToken = Rx(null);

  final generalController = Get.find<GeneralController>();

  RxString countryCode = RxString('+233');

  String baseUrl = 'https://ac537947563e0fe33f7aeca51ff880b1.serveo.net';


  Future<String> fetchCsrfToken() async {
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_csrf_token'),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        final csrfToken = data['csrf_token'] as String;
        return csrfToken;
      } else {
        throw Exception('Failed to fetch CSRF token');
      }
    } catch (e) {
      print('Exception during CSRF token fetch: $e');
      throw Exception('Failed to fetch CSRF token');
    }
  }

  String _extractCsrfTokenFromHeaders(Map<String, String> headers) {
    String csrfToken = '';
    final cookies = headers['set-cookie']?.split(', ');
    if (cookies != null) {
      for (var cookie in cookies) {
        if (cookie.contains('csrftoken')) {
          csrfToken = cookie.split(';')[0].split('=')[1];
          break;
        }
      }
    }
    return csrfToken;
  }


  // User Login Function
  // Future<void> logIn(String usernameOrEmail, String password) async {
  //   try {
  //     // Perform client-side validation
  //     if (usernameOrEmail.isEmpty || password.isEmpty) {
  //       Utils.showErrorToast('Error', 'Please enter username/email and password');
  //       return;
  //     }

  //     // Make HTTP POST request to log in user
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/login/'),
  //       headers: <String, String>{'Content-Type': 'application/json'},
  //       body: jsonEncode(<String, String>{
  //         'username_or_email': usernameOrEmail,
  //         'password': password,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // User successfully logged in
  //       Get.offAll(() => MainScreen(user: FirebaseAuth.instance.currentUser!));
  //     } else {
  //       // Login failed
  //       Utils.showErrorToast('Error', 'Invalid username/email or password');
  //     }
  //   } catch (e) {
  //     print('Exception during login: $e');
  //     Utils.showErrorToast('Error', 'Failed to log in');
  //   }
  // }

  // Check credentials in databse to see if  they exist or not
  Future<bool> checkCredentials(String firstName, String lastName, String email, String studentId, String phoneNumber, String password) async {
    try {
      // Fetch CSRF token
      final String csrfToken = await fetchCsrfToken();

      // Make HTTP POST request to check user credentials
      final response = await http.post(
        Uri.parse('$baseUrl/check_auth/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-CSRFToken': csrfToken, // Include CSRF token in headers
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'student_id': studentId,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final bool credentialsValid = data['credentials_valid'] as bool;
        return credentialsValid;
      } else {
        throw Exception('Failed to check credentials');
      }
    } catch (e) {
      print('Exception during credentials check: $e');
      throw Exception('Failed to check credentials');
    }
  }

  void signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.to(()=> const LoginScreen());
      // Navigate to the login screen or any other screen after logout
    } catch (error) {
      print('Error signing out: $error');
      // Handle any errors that occur during sign out
    }
  }


  // Sign Up With Firebase
  void registerUser(String firstName, String lastName, String email, String student_id, String phoneNumber, String password) async{
    Utils.showProgressDialog();

    try{
      final authUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      // final idToken = await authUser.user?.getIdToken();
      // final String csrfToken = await fetchCsrfToken();

      // final response = await http.post(
      //   Uri.parse('$baseUrl/register_user'),
      //    headers: <String, String>{
      //     'Content-Type': 'application/json', // Specify content type as form-urlencoded
      //     'X-CSRFToken': csrfToken, // Include CSRF token in headers
      //   },
      //   body: jsonEncode({
      //     'firstname': firstName,
      //     'lastname': lastName,
      //     'email': email,
      //     'student_id': student_id,
      //     'phone_number': phoneNumber,
      //     'password': password,
      //   })
      // );

      if(authUser.user == null){
        Get.back();
        Utils.showErrorToast("Error", "Unable to create user");
      }else{
        final String userId = authUser.user!.uid;
        final userData = <String, dynamic>{
          "uid": userId,
          "firstname": firstName,
          "lastname": lastName,
          "student_id": student_id,
          "phone": phoneNumber,
          "email": email,
          "image": ""
        };

        await FirebaseFirestore.instance
          .collection("students")
          .doc(authUser.user!.uid)
          .set(userData);

        Get.back();

        Utils.showSuccessToast("Success", "Account created successfully");

        Get.to(()=> const CompletedScreen());

        // if (authUser.statusCode == 201) {
        //   // Registration successful
        //   print('Registration successful');
        //   Utils.showSuccessToast('Success', 'User has successfully been created');
        //   Get.offAll(()=> const CompletedScreen());
        // } else {
        //   // Registration failed
        //   print('Registration failed: ${response.body}');
        //   Utils.showErrorToast('Error', 'Failed to register user ${response.body}');
        //   Get.back();
        // }
      } 
    }catch(error) {
      print('Firebase registration error: $error');
      Utils.showErrorToast("Error", '$error');
      Get.back();
    }
  }

  void login({required String email, required String password}) async{
    Utils.showProgressDialog();

    try{

      final authInstance = FirebaseAuth.instance;

      final response = await authInstance.signInWithEmailAndPassword(email: email, password: password);

      Get.back();

      if(response.user == null){
        Utils.showErrorToast("Error", "Enter valid email or password");
      }else{
        Get.offAll(()=> const CompletedScreen());
      }

    }catch(e){
      print(e);
      print(e.runtimeType);
      Get.back();
      Utils.showErrorToast("Error", (e as FirebaseAuthException).message!);
    }

  }

  void resetPassword(String email) async{
    try {
      Utils.showProgressDialog();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Utils.showSuccessToast('Success', 'Password reset email has successfully been sent');

      Get.to(()=> const LoginScreen());
    } catch (error) {
      Utils.showErrorToast('Error', '$error');
    }
  }


  // On hold for now
}