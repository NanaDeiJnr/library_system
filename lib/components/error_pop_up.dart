import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ErrorPopUp extends StatelessWidget {
  final String? title;
  final String? message;
  const ErrorPopUp({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 70),
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/animation_error.json',
              height: 150
            ),
            const SizedBox(height: 10,),

            Text(
              title ?? "Error Message",
              style: GoogleFonts.workSans(
                fontSize: 19,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 5,),

            Text(
              message ?? 'Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa Blaaaaaa, blaaaaaa, blaaaaa',
              softWrap: true,
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                
              ),
            ),

            const SizedBox(height: 12,),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Exit',
                style: GoogleFonts.workSans(
                  color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}