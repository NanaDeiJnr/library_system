import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class BookingDetailsCard extends StatelessWidget {
  final String? studentId;
  final String? username;
  final String? userEmail;
  final String? status;
  final Timestamp? requestedDate;
  final Timestamp? bookingDate;
  final Timestamp? bookingTime;
  final String? startTime;
  final String? endTime;
  final void Function()? onTap;
  const BookingDetailsCard({super.key, this.studentId, this.username, this.userEmail, this.status, this.requestedDate, this.startTime, this.endTime, this.bookingDate, this.bookingTime, this.onTap});

  @override
  Widget build(BuildContext context) {
    DateTime requestedDateTime = requestedDate!.toDate();
    DateTime bookingDateTime = bookingDate!.toDate();
    DateTime bookingTimes = bookingTime!.toDate();

    String dateString = DateFormat('dd MMMM, yyyy').format(requestedDateTime);
    String bookingDateString = DateFormat('dd MMMM, yyyy').format(bookingDateTime);
    String bookinTimeString = DateFormat('HH:mm').format(bookingTimes);
    


    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: MainColors.primaryColor,
            width: 1
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: MainColors.primaryColor,
                  ),
                ),
      
                const Spacer(),
      
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dateString
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          startTime ?? '00:00'
                        ),
                        const Text(
                          ' - '
                        ),
                        Text(
                          endTime ?? '00:00'
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
      
            const Divider(),
      
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booked on: $bookingDateString'
                    ),
                     Text(
                      'Booked at: $bookinTimeString'
                    )
                  ],
                ),
      
                const Spacer(),
      
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(
                      status ?? 'Pending',
                      style: const TextStyle(
                        color: Colors.amber
                      ),
                    ),
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