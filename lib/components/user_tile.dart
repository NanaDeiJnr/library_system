import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class UserTile extends StatelessWidget {
  final String? username;
  final String? email;
  final void Function()? onTap;
  final void Function()? onIconTap;
  final bool requestSent;
  const UserTile({super.key, this.username, this.email, this.onTap, this.onIconTap, required this.requestSent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: MainColors.primaryColor)
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
      
            const SizedBox(width: 5,),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? ''
                ),
      
                Text(
                  email ?? ''
                ),
              ],
            ),

            const Spacer(),

            RoundIconButton(
              icon: requestSent ? const Icon(Icons.check) : const Icon(Icons.person_add),
              onTap: onIconTap,
            )
          ],
        ),
      ),
    );
  }
}