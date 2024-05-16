import 'package:flutter/material.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class CustomHourContainer extends StatelessWidget {
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? bodyColor;
  final String? title;
  final String? body;
  final void Function()? onTap;
  const CustomHourContainer({super.key, this.borderColor, this.backgroundColor, this.titleColor, this.bodyColor, required this.title, this.body, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor!,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            width: 1,
            color: borderColor ?? MainColors.primaryColor
          )
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                body ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: titleColor ?? Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}