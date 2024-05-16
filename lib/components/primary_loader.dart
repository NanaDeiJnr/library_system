import 'package:flutter/material.dart';

class PrimaryLoader extends StatelessWidget {
  const PrimaryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              spreadRadius: 1.0,
              color: Colors.grey.shade200
            )
          ],
        ),
        child: const CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}