import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onTap;
  const PrimaryButton({super.key, required this.title, this.backgroundColor, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        // width: 50,
        // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.workSans(
              fontSize: 17,
              color: textColor,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}