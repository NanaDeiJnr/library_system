import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class PasswordResetContainer extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? contact;
  final void Function()? onTap;
  const PasswordResetContainer({super.key, this.icon, this.title, this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: MainColors.secondaryColor
          ),
          color: MainColors.primaryWhite
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300
              ),
              child: icon
            ),
            const SizedBox(width: 10,),
    
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 3,),
    
                Text(
                  contact ?? '',
                  style: GoogleFonts.workSans(
                    // fontWeight: FontWeight.w500,
                    color: MainColors.greyTextColor
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}