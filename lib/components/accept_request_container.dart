import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class RequestTile extends StatelessWidget {
  final String? username;
  final String? email;
  final void Function()? onTap;
  final void Function()? onAccept;
  final bool acceptRequest;

  const RequestTile({
    Key? key,
    this.username,
    this.email,
    this.onTap,
    this.onAccept,
    required this.acceptRequest,
  }) : super(key: key);

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
                border: Border.all(color: MainColors.primaryColor),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username ?? ''),
                Text(email ?? ''),
              ],
            ),
            const Spacer(),
            // Button
            GestureDetector(
              onTap: onAccept, // Disable onTap if request is accepted
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 2),
                ),
                child: Row(
                  children: [
                    RoundIconButton(
                      icon: acceptRequest ? const Icon(Icons.check) : const Icon(Icons.person_add),
                    ),
                    Text(
                      acceptRequest ? 'Accepted' : 'Accept',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
