// // ignore_for_file: avoid_print, unused_local_variable, unused_import

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:lmsystem_app/components/error_pop_up.dart';
// import 'package:lmsystem_app/components/primary_loader.dart';
// import 'package:lmsystem_app/components/study_group_container.dart';
// import 'package:lmsystem_app/components/success_pop_up.dart';
// import 'package:lmsystem_app/screens/main_screen/study_group.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   // http://127.0.0.1:8000/ => API Endpoint
//   List? bookings;
//   List? groups;

//   Future<void> test() async{
//     const String apiUrl = 'https://3ef37e6c65e7e0e1107cc66bb673f0d0.serveo.net/list_booking';
//     const String url = 'http://127.0.0.1:8000/list_booking';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       print(response.body);
//       final Map<String, dynamic> data = json.decode(response.body);

//       setState(() {
//         bookings = data['bookings'];
//       });
//     } else {
//       print('Failed to load data');
//       print('Status Code: ${response.statusCode}');
//     }
//   }

//   Future<void> listGroups() async{
//     const String apiUrl = 'https://3ef37e6c65e7e0e1107cc66bb673f0d0.serveo.net/study_groups';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       print(response.body);
//       final Map<String, dynamic> data = json.decode(response.body);

//       setState(() {
//         groups = data['study_groups'];
//       });
//     } else {
//       print('Failed to load data');
//       print('Status Code: ${response.statusCode}');
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     test();
//     listGroups();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Show Success Pop Up'),
//               onPressed: () {
//                 // SuccessPopUp;
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return const SuccessPopUp(
                     
//                     );
//                   },
//                 );
//               },
//             ),
//             const SizedBox(height: 20,),

//             ElevatedButton(
//               child: const Text('Show Error Pop Up'),
//               onPressed: () {
//                 // SuccessPopUp;
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return const ErrorPopUp();
//                   },
//                 );
//               },
//             ),

//             const SizedBox(height: 20,),

//             ElevatedButton(
//               child: const Text('Create Study Group'),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (_)=> const CreateStudyGoup()));
//               },
//             ),

//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: groups!.length,
//             //     itemBuilder: (context, index) {
//             //       return ListTile(
//             //         title: Text(groups![index]['name'] ?? ''), // Added Text widget
//             //         // subtitle: Text(groups![index]['members'', '] ?? ''), // Added Text widget
//             //       );
//             //     },
//             //   ),
//             // ),

//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: bookings!.length,
//             //     itemBuilder: (context, index) {
//             //       return ListTile(
//             //         title: Text(bookings![index]['student']['student_id'] ?? ''), // Added Text widget
//             //         subtitle: Text(bookings![index]['student']['firstname'] ?? ''), // Added Text widget
//             //       );
//             //     },
//             //   ),
//             // ),

//             // const PrimaryChatCard(

//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }