// ignore_for_file: library_prefixes

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart' as ElegantNotificationArrays;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';


class Utils{

  static showProgressDialog(){
    if(Get.overlayContext!.mounted){
      CustomProgressDialog progressDialog = CustomProgressDialog(
        Get.overlayContext!,
        dismissable: true,
        loadingWidget: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator( color: Colors.white,)
            ),
          ),
        ),
      );
      progressDialog.show();
    }
  }

  static dismissProgressPopup(){
    if(Get.overlayContext!.mounted){
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  static String formatTimestampDate(int timestamp) {
    var format = DateFormat('dd MMM, yyyy'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampDate2(int timestamp) {
    var format = DateFormat('MM/dd/yyyy'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampDate3(int timestamp) {
    var format = DateFormat('yyyy-MM-dd'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampTime(int timestamp) {
    var format = DateFormat('HH:mm'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampTimeAmPm(int timestamp) {
    var format = DateFormat('hh:mm a'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampDateTime(int timestamp) {
    var format = DateFormat('dd MMM, yyyy HH:mm'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatCreatedAt(String date) {
    var format = DateFormat('dd MMM, yyyy'); // <- use skeleton here
    return format.format(DateTime.parse(date));
  }
  static String formatCreatedAtWithTime(String date) {
    var format = DateFormat('MM/dd/yyyy ~ hh:mm a'); // <- use skeleton here
    return format.format(DateTime.parse(date));
  }

  static String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("HH:mm").format(now);
  }

  static String getTimeAgoTillYesterdayTimeStamp(DateTime timestamp) {
    DateTime chatDate = timestamp;
    if (calculateDifference(chatDate) == 0) {
      //today
      var format = DateFormat('hh:mm a'); // <- use skeleton here
      return format.format(chatDate);
    } else if (calculateDifference(chatDate) == -1) {
      //yesterday
      return 'Yesterday';
    } else {
      var format = DateFormat('MM/dd/yyyy'); // <- use skeleton here
      return format.format(chatDate);
    }
  }

  static String getTimeAgoTillYesterday(int timestamp) {
    DateTime chatDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (calculateDifference(chatDate) == 0) {
      //today
      var format = DateFormat('hh:mm a'); // <- use skeleton here
      return format.format(chatDate);
    } else if (calculateDifference(chatDate) == -1) {
      //yesterday
      return 'Yesterday';
    } else {
      var format = DateFormat('MM/dd/yyyy'); // <- use skeleton here
      return format.format(chatDate);
    }
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }


  static showSuccessToast(String title, String message){
    if(Get.overlayContext!.mounted){
      ElegantNotification.success(
        title: Text(
          title,
          style: const TextStyle(
              // color: kPrimaryTextColorDark,
              fontWeight: FontWeight.bold
          ),
        ),
        description: Text(
          message,
          style: const TextStyle(
              // color: kPrimaryTextColorLight,
              fontSize: 12
          ),
        ),
        // notificationPosition: ElegantNotificationArrays.NotificationPosition.topCenter,
        animation: ElegantNotificationArrays.AnimationType.fromTop,
        toastDuration: const Duration(seconds: 5),
      ).show(Get.overlayContext!);
    }
  }
  static showErrorToast(String title, String message){
    if(Get.overlayContext!.mounted){
      ElegantNotification.error(
        title: Text(
          title,
          style: const TextStyle(
              // color: kPrimaryTextColorDark,
              fontWeight: FontWeight.bold
          ),
        ),
        description: Text(
          message,
          style: const TextStyle(
              // color: kPrimaryTextColorLight,
              fontSize: 12
          ),
        ),
        toastDuration: const Duration(seconds: 5),
        // notificationPosition: ElegantNotificationArrays.NotificationPosition.topCenter,
        animation: ElegantNotificationArrays.AnimationType.fromTop,
      ).show(Get.overlayContext!);
    }
  }

  // static getStatusTextColor(String status){
  //   if(status == 'HOLD' || status == "CANCELLED"){
  //     return HexColor.generateMaterialColor('#506690');
  //   }else if(status == 'PENDING'){
  //     return HexColor.generateMaterialColor('#FAD776');
  //   }else if(status == 'FAILED'){
  //     return HexColor.generateMaterialColor('#DF4759');
  //   } else if(status == 'REFUNDED'){
  //     return HexColor.generateMaterialColor('#7C69EF');
  //   } else{
  //     return HexColor.generateMaterialColor('#42BA96');
  //   }
  // }

  /*static getStatusText(String status){

    static const ongoing = '3';
    static const completed = '4';
    static const cancelled = '5';
    static const rejected = '6';
    static const inactive = '7';

    if(status == RequestStatus.pending){
      return 'Pending';
    }else if(status == RequestStatus.accepted){
      return 'Accepted';
    }else if(status == RequestStatus.assigned){
      return 'Assigned';
    } else if(status == RequestStatus.accepted){
      return HexColor.generateMaterialColor('#7C69EF');
    } else{
      return HexColor.generateMaterialColor('#42BA96');
    }
  }*/

}

class SecurityUtils{
//for AES Algorithms


  static String encryptAES(String plainText){
    //print(Encrypt.Key.fromSecureRandom(32).base64);
    final key = Encrypt.Key.fromBase64('tm9OmSzHbkbihiv4zEEIfvRCg5YtW7G/bu0c1v/sD/4=');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptAES(Encrypted encrypted){
    final key = Encrypt.Key.fromBase64('tm9OmSzHbkbihiv4zEEIfvRCg5YtW7G/bu0c1v/sD/4=');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    //print(decrypted);
    return decrypted;
  }
}