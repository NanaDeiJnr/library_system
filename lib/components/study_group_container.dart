import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryChatCard extends StatelessWidget {
  final String? username;
  final String? time;
  final String? message;
  final String? chatNumber;
  final void Function()? onTap;
  const PrimaryChatCard({super.key, this.username, this.time, this.message, this.chatNumber, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1
          )
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.people, color: Colors.white,),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      username ?? 'Username',
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.5
                      ),
                    ),
    
                    const Spacer(),
    
                    Text(
                      time ?? '00:00',
                      style: GoogleFonts.workSans(
                        color: Colors.black54,
                        fontSize: 14
                      ),
                    )
                  ],
                ),
    
                const SizedBox(height: 5,),
    
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          message ?? ' Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas sed, fugit inventore quos fuga ab? Quas, deleniti.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.workSans(
                            color: Colors.black54,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
    
                    const SizedBox(width: 25,),
    
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Text(
                        chatNumber ?? '1',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}