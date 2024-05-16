// ignore_for_file: avoid_print


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lmsystem_app/components/primary_news_container.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/notification_screen.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              // Header Section
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.waving_hand, size: 16,color: Color(0xFFD4A685),),
                          SizedBox(width: 5,),
                          Text(
                            'Hello There!',
                            style: TextStyle(
                              color: MainColors.greyTextColor,
                              fontSize: 18
                            ),
                          )
                        ],
                      ),
                      
                      Text(
                        // User name
                        '${widget.user.email}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                      
                  const Spacer(),
                      
                  RoundIconButton(
                    icon: const Icon(Icons.search),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      // print(widget.user.displayName);
                      // authController.fetchDataWithToken();
                      authController.signOutUser();
                    },
                  ),
                      
                  const SizedBox(width: 10,),
                      
                  RoundIconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const NotificationScreen()));
                    },
                  ),
                ],
              ),
          
              const Divider(),
              // Body Section
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: MainColors.tertiaryBgColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/reading.svg',
                                height: 80,
                              ),
                              const Expanded(
                                child: Text(
                                  'Unlock a world of knowledge with our online library booking app!',
                                  style: TextStyle(
                                    color: MainColors.primaryColor
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                  
                        const SizedBox(height: 20,),
                        const NewsContainer(
                          image: 'assets/images/google.png',
                          header: 'Library Admin',
                          account: 'admin@gmail.com',
                          imageUrl: 'assets/images/apple-logo.png',
                        ),
          
                         const NewsContainer(
                          image: 'assets/images/google.png',
                          header: 'Library Admin',
                          account: 'admin@gmail.com',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}