import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class PrimaryRoomContainer extends StatelessWidget {
  const PrimaryRoomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 2.3),
      decoration: BoxDecoration(
        color: MainColors.primaryColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Image.asset(
                    'assets/images/google.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),

          const Expanded(child: Text('Hello World'))
        ],
      ),
    );
  }
}