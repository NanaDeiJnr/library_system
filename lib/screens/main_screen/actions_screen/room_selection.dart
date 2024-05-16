import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/custom_room_vector.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  final studyArea = ['All', 'Study Room', 'Lounge'];
  int selectedIndex = 0;
  int currentNumber = 1;
  int loungeIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                      'Select Area',
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
                        // Button onTap to be handled here
                      },
                    )
                  ],
                ),
              ),
            ),

            // Selection Tabs
            // SizedBox(
            //   height: 50,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: studyArea.length,
            //     shrinkWrap: true,
            //     primary: false,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedIndex = index;
            //           });
            //         },
            //         child: Container(
            //           width: MediaQuery.of(context).size.width /3,
            //           // margin: EdgeInsets.symmetric(horizontal: 5),
            //           decoration: BoxDecoration(
            //             color: index == selectedIndex ? Colors.white : Colors.grey.shade200,
            //             border: index == selectedIndex ? const Border(
            //               bottom: BorderSide(
            //                 width: 3,
            //                 color: MainColors.primaryColor
            //               )
            //             ) : Border.all(
            //               color: Colors.grey.shade200
            //             )
            //           ),
            //           child: Center(
            //             child: Text(
            //               studyArea[index],
            //               style: const TextStyle(
            //                 fontSize: 17,
            //                 fontWeight: FontWeight.w600
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // Horizontal Room Display
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      // color: Colors.amber,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          return CustomRoomVector(
                            roomId: 'R-${currentNumber++}',
                          );
                        }),
          
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        child: Row(
                          children: [

                            //Lounge Items in a grid view
                            Expanded(
                              child: SizedBox(
                                // color: Colors.green,
                                child: GridView.builder(
                                  itemCount: 24,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.only(left: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return CustomLoungeVector(
                                      loungeId: 'L${loungeIndex++}',
                                    );
                                  },
                                )
                              ),
                            ),

                            // Vertical View Display
                            SizedBox(
                              width: 120,
                              // color: Colors.deepPurpleAccent,
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return CustomRoomVert(
                                    roomId: 'R-${currentNumber++}',
                                  );
                                },
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -3),
                    color: Colors.grey.shade300,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    // blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: PrimaryButton(
                title: 'Reserve Area',
                backgroundColor: MainColors.primaryColor,
                textColor: Colors.white,
                onTap: () {

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}