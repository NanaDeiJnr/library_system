import 'package:flutter/material.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class ListViewButtonContainer extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const ListViewButtonContainer({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: MainColors.tertiaryBgColor,
          borderRadius: BorderRadius.circular(7)
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}