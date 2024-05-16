import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/profile_menu.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Firstname Lastname',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'user@email.com',
                              style: TextStyle(
                                color: MainColors.greyTextColor
                              ),
                            ),
                            TextSpan(
                              text: '-',
                            ),
                            TextSpan(
                              text: 'PS/TER/10/0290',
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                color: MainColors.secondaryColor,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: const Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    
                  )
                ],
              ),

              const Divider(),

              // const SizedBox(height: 20,),

              ProfileMenu()
            ],
          ),
        ),
      )
    );
  }
}