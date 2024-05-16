// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, unused_field


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmsystem_app/components/custom_hour_container.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/primary_input.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/services/chat_service/chat_service.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';
import 'package:lmsystem_app/utils/utils.dart';

class PlaceBooking extends StatefulWidget {
  const PlaceBooking({super.key});

  @override
  State<PlaceBooking> createState() => _PlaceBookingState();
}

class _PlaceBookingState extends State<PlaceBooking> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  int selectedStartIndex = 0;
  int selectedEndIndex = 0;

  late DateTime selectedDate;

  List<int> bookedTimeIntervals = [];
  List<String> bookingIds = [];
  List<Map<String, dynamic>> bookingDataList = [];
  List? bookingData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookings();
    getBookingIds();
    selectedDate = DateTime.now();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    print(selectedDate.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  RoundIconButton(
                    icon: const Icon(Icons.arrow_back),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 10,),

                  const Text(
                    'Book An Area',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: const Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      // Handle onTap function here
                      print(bookingIds);
                      print(bookingDataList);
                    },
                  )
                ],
              ),
            ),

            const Divider(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Select Date: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          PrimaryInputField(
                            readOnly: true,
                            hint: "${selectedDate.toLocal()}".split(' ')[0],
                          ),
                          const SizedBox(height: 5,),
                          
                          PrimaryButton(
                            onTap: () {
                              print(selectedDate.toLocal());
                              _selectDate(context);
                            },
                            title: 'Select date',
                            textColor: Colors.white,
                            backgroundColor: MainColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),
                
                    // Select Room option
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Select Study Area: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Column(
                        children: [
                          const PrimaryInputField(
                            hint: 'Study Area',
                            readOnly: true,
                          ),
                          const SizedBox(height: 10,),
                
                          PrimaryButton(
                            title: 'Choose Area',
                            backgroundColor: MainColors.primaryColor,
                            textColor: Colors.white,
                            onTap: () {
                              showRoomDialog(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (_)=> const RoomSelectionScreen())
                              // );
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                
                    // Select time option
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Select Start Time: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // Hour Intervals
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemBuilder: (context, index) {
                          // int startTime = index;
                          // int endTime = index + 2 % 24;
                          // bool isBooked = isTimeSlotBooked(startTime, endTime);
                          return CustomHourContainer(
                            onTap: () {
                              setState(() {
                                selectedStartIndex = index;
                                selectedEndIndex = (index + 2) % 24;
                              });
                            },
                            title: 'Day',
                            body: '${index.toString().padLeft(2, '0')}:00',
                            backgroundColor: index == selectedStartIndex ? MainColors.primaryColor : Colors.white,
                            titleColor: index == selectedStartIndex ? Colors.white : Colors.black,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15,),
                
                    // Select End time option
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Select End Time: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // Hour Intervals
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemBuilder: (context, index) {
                          return CustomHourContainer(
                            onTap: () {
                              setState(() {
                                selectedEndIndex = index;
                                selectedStartIndex = (index - 2) % 24;
                              });
                            },
                            title: 'Day',
                            body: '${index.toString().padLeft(2, '0')}:00',
                            backgroundColor: index == selectedEndIndex ? MainColors.primaryColor : Colors.white,
                            titleColor: index == selectedEndIndex ? Colors.white : Colors.black,
                          );
                        },
                      ),
                    ),
                
                    const SizedBox(height: 15,),
                
                    // Enter Number of Students or Select group for which the reservation is being made
                    // The app will automatically inflate the field with the number of students in the group
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Select Students:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: Expanded(
                        child: PrimaryButton(
                          textColor: Colors.white,
                          title: 'Select Students',
                          backgroundColor: MainColors.primaryColor,
                          onTap: () {
                            showBottomSheet(context);
                          },
                        ),
                      ),
                    ),
                

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: PrimaryButton(
                        textColor: Colors.white,
                        title: 'Place Reservation',
                        backgroundColor: MainColors.primaryColor,
                        onTap: () {
                          bookSlot(selectedDate.toLocal());
                          print(selectedDate);
                        },
                      ),
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

  // Book slot function
  void bookSlot(DateTime selectedDate) async {
    Utils.showProgressDialog(); // Show progress dialo while function is active
    User? currentUser = _auth.currentUser;

    if (currentUser  == null){
      return;
    }

    DocumentSnapshot userData = await _firestore.collection('students').doc(currentUser.uid).get();
    String? username = userData['firstname'] + ' ' + userData['lastname']; // Set users name
    String? student_id = userData['student_id']; // Get user's student id

    final Map<String, dynamic> bookingData = {
      'userId': currentUser.uid,
      'email': currentUser.email,
      'username': username,
      'student_id': student_id,
      'dateOfBooking': DateTime.now(),
      'requestedDate': selectedDate,
      'startTime': '$selectedStartIndex:00',
      'endTime': '$selectedEndIndex:00',
      'status': 'Pending'
      // 'studyArea': 'studyArea'
    };

    try {
      await _firestore.collection('bookings').add(bookingData);

      Utils.showSuccessToast('Booking Successful', 'Your booking was succesful');

      Get.back();
    } catch (error) {
      Utils.showErrorToast('Booking Unsuccessful', 'Booking was unsuccessful. please try again in some few minutes');
    }
  }

  // Get bookings from firebase firestore
  Future<void> getBookings() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('bookingd').get();

      querySnapshot.docs.forEach((doc) {
        int startTime = doc['startTime'];
        int endTime = doc['endTime'];

        for (int i = startTime; i <= endTime; i++) {
          bookedTimeIntervals.add(i % 24);
        }
      });

      setState(() {
        
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getBookingIds() async {
    try {
      // Retrieve all documents from the 'bookings' collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('bookings')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

      // Extract the IDs and data of all bookings
      List<String> ids = [];
      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((doc) {
        String id = doc.id;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Explicit cast

        ids.add(id);
        dataList.add(data);
      });


      print('Booking IDs: $ids'); // Debugging statement

      // Update the list of booking IDs and booking data
      setState(() {
        bookingIds = ids;
        bookingDataList = dataList;
      });
    } catch (error) {
      print('Error getting booking IDs: $error');
      // Handle error
    }
  }

  bool isTimeSlotBooked(int startTime, int endTime) {
    for (var bookingData in bookingDataList) {
      int bookedStartTime = bookingData['startTime'];
      int bookedEndTime = bookingData['endTime'];

      // Check if the time slot overlaps with any booked time slots
      if ((startTime >= bookedStartTime && startTime < bookedEndTime) ||
          (endTime > bookedStartTime && endTime <= bookedEndTime)) {
        return true;
      }
    }
    return false;
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12)
            )
          ),
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Select Friends',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                _displayFriends(),
              ],
            ),
          )
        );
      },
    );
  }

  // Study room dialog
  void showRoomDialog(BuildContext context) {
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
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [        
                    const Text(
                      'Select Room:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
            
                    const Spacer(),
            
                    RoundIconButton(
                      icon: Icon(Icons.close),
                      backgroundColor: Colors.grey.shade200,
                      onTap: () {
                        
                      },
                    )
                  ],
                ),

                Expanded(
                  child: Container(
                    color: MainColors.tertiaryBgColor,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('Study Room plan goes here'),
                    ),
                  ),
                ),

                PrimaryButton(
                  title: 'Select Room',
                  backgroundColor: MainColors.primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    // Handle button onTap here
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }



  Widget _displayFriends() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('students')
        .doc(_auth.currentUser?.uid)
        .collection('friends')
        .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final friends = snapshot.data!.docs;

        if (friends.isEmpty) {
          return const Center(child: Text('You have no friends yet.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            final friendId = friend.id;
            return FutureBuilder<Map<String, dynamic>?>(
              future: getUserById(friendId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Show nothing while loading
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final friendData = snapshot.data!;
                final String username = friendData['firstname'] + ' ' + friendData['lastname'];

                return ListTile(
                  title: Text(username),
                  subtitle: Text(friendData['email']),
                  trailing: RoundIconButton(
                    icon: const Icon(Icons.check_box_outline_blank),
                    onTap: () {
                      
                    },
                  ),
                );

              }
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getUserById (String userId) async{
    return(
      await FirebaseFirestore.instance.collection('students')
      .doc(userId)
      .get()
    ).data();
  }

}