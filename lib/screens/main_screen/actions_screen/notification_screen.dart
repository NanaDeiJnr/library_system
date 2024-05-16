import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10
          ),
          child: Column(
            children: [
              // Header section
              Row(
                children: [
                  RoundIconButton(
                    icon: const Icon(Icons.arrow_back),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10,),

                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400
                    ),
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: const  Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    isMenuButton: true,
                  )
                ],
              ),

              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}