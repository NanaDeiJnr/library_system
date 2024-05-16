import 'package:flutter/material.dart';

class RoomContainer extends StatelessWidget {
  final String? image;
  const RoomContainer({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Expanded(
            child: Image.asset(
              image ?? 'assets/images/apple.png' 
            ),
          ),


        ],
      ),
    );
  }
}