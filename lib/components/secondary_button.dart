import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final String? image;
  final Color? borderColor;
  final double? borderWidth;
  final void Function()? onTap;
  const SecondaryButton({super.key, required this.title, this.backgroundColor, this.textColor, this.onTap, this.image, this.borderColor, this.borderWidth});

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
          border: Border.all(
            color: borderColor!,
            width: borderWidth ?? 0
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image ?? '',
                height: 22,
              ),
              const SizedBox(width: 5,),
              Text(
                title,
                style: GoogleFonts.workSans(
                  fontSize: 17,
                  color: textColor,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}