import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/options.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),

            Text(
              'Account',
              style: TextStyle(),
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.person_outline),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Profile Information',
                ),

                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.settings_outlined),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Preferences',
                ),

                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Notifications',
                ),
              ],
            ),

            const Divider(),

            Text(
              'Help & Support',
              style: TextStyle(),
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.question_mark_outlined),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Support',
                ),

                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.settings_outlined),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Preferences',
                ),

                OptionsContainer(
                  icon: RoundIconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: 'Notifications',
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}