// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lmsystem_app/components/booking_details_card.dart';
import 'package:lmsystem_app/components/list_view_button_container.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/make_booking.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<String> bookingIds = [];
  List<Map<String, dynamic>> bookingDataList = [];
  final timeFrame = ['Today', 'Yesterday', 'This Week', 'Last Month', 'Last Three Months', 'This Year'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                children: [
                  const Text(
                    'Bookings',
                    style: TextStyle(
                      fontSize: 23, 
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      // Handle Button onTap Function
                      print(bookingDataList);
                    },
                  )
                ],
              ),
            ),

            const Divider(),

            Expanded(
              child: SingleChildScrollView (
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      color: Colors.amber,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'User\'s booking usage'
                            ),
                            PrimaryButton(
                              title: 'Book a Place',
                              textColor: Colors.white,
                              backgroundColor: MainColors.primaryColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_)=> const PlaceBooking())
                                ); 
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 10,),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Text(
                            'Recent Bookings', 
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                            ),
                          ),
                          const Spacer(),
                      
                          GestureDetector(
                            child: const Text(
                              'See all', 
                              style: TextStyle(
                                color: MainColors.greyTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.horizontal,
                        itemCount: timeFrame.length,
                        itemBuilder: (context, index) {
                          return ListViewButtonContainer(
                            title: timeFrame[index],
                            onTap: () {

                            },
                          );
                        },
                      ),
                    ),
                
                    const SizedBox(height: 10,),
                
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: getBookingData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          // Or any loading indicator
                           return Text('Error: ${snapshot.error}');
                        }

                        // if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return const Center(
                        //     child: CircularProgressIndicator()
                        //   ); 
                        // }

                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: bookingDataList.length,
                          itemBuilder: (context, index) {
                            return BookingDetailsCard(
                                username: bookingDataList[index]['username'],
                                startTime: bookingDataList[index]['startTime'],
                                endTime: bookingDataList[index]['endTime'],
                                requestedDate: bookingDataList[index]['requestedDate'],
                                bookingDate: bookingDataList[index]['dateOfBooking'],
                                bookingTime: bookingDataList[index]['dateOfBooking'],
                                onTap: () {
                                  showBookingDialog(context, bookingDataList[index]);
                                },
                              );
                          },
                        );
                      }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBookingDialog(BuildContext context, Map<String, dynamic> bookingDetails) {
    // Convert timestamps to DateTime objects
    DateTime? requestedDate = bookingDetails['requestedDate'] != null ? (bookingDetails['requestedDate'] as Timestamp).toDate() : null;
    DateTime? bookingDate = bookingDetails['dateOfBooking'] != null ? (bookingDetails['dateOfBooking'] as Timestamp).toDate() : null;
    DateTime? bookingTime = bookingDetails['timeOfBooking'] != null ? (bookingDetails['timeOfBooking'] as Timestamp).toDate() : null;

    // Format DateTime objects to strings if they are not null
    String requestedDateString = requestedDate != null ? DateFormat('yyyy-MM-dd').format(requestedDate) : '';
    String bookingDateString = bookingDate != null ? DateFormat('yyyy-MM-dd').format(bookingDate) : '';
    String bookingTimeString = bookingTime != null ? DateFormat('HH:mm:ss').format(bookingTime) : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          padding: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: MainColors.primaryColor
                    ),
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: const Icon(Icons.close),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              ),

              const Divider(),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Booked by: ${bookingDetails['username']}'),
                      Text('${bookingDetails['email']}')
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Time'
                      ),
                      Text('${bookingDetails['startTime']}'),
                    ],
                  ),

                  const Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'End Time'
                      ),
                      Text('${bookingDetails['endTime']}'),
                    ],
                  )
                ],
              ),

              // Continue from here
              Text('Requested Date: $requestedDateString'),
              Text('Booking Date: $bookingDateString'),
              Text('Booking Time: $bookingTimeString'),
            ],
          ),
        );
      },
    );
  }

  Stream<List<Map<String, dynamic>>> getBookingData() async* {
    try {
      // Listen to changes in the 'bookings' collection
      Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance.collection('bookings')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('dateOfBooking', descending: true)
        .snapshots();

      await for (QuerySnapshot querySnapshot in snapshots) {
        bookingDataList.clear();
        // Extract the IDs and data of all bookings
        List<String> ids = [];
        // List<Map<String, dynamic>> dataList = [];

        querySnapshot.docs.forEach((doc) {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Explicit cast

          ids.add(id);
          bookingDataList.add(data);
        });

        print('Booking IDs: $ids');
        print('Data: $bookingDataList'); // Debugging statement

        // Yield the updated list of booking data
        // yield dataList;
      }
    } catch (error) {
      print('Error getting booking data: $error');
      // Handle error
    }
  }

}