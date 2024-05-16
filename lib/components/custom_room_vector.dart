import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomRoomVector extends StatelessWidget {
  final String? roomId;
  const CustomRoomVector({super.key, this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 120,
      // height: 200,
      // color: Colors.amber,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeatVector(),
              SizedBox(width: 5,),
              SeatVector(),
            ],
          ),
          const SizedBox(height: 5,),

          TableVector(
            roomId: roomId,
          ),

          const SizedBox(height: 5,),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeatVector(),
              SizedBox(width: 5,),
              SeatVector(),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRoomVert extends StatelessWidget {
  final String? roomId;
  const CustomRoomVert({super.key, this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 120,
      // height: 200,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeatVectoVertical(),
              SizedBox(height: 5,),
              SeatVectoVertical(),
            ],
          ),
          const SizedBox(width: 5,),

          TableVectorVertical(
            roomId: roomId,
          ),

          const SizedBox(width: 5,),

          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeatVectoVertical(),
              SizedBox(height: 5,),
              SeatVectoVertical(),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomLoungeVector extends StatelessWidget {
  final String? loungeId;
  const CustomLoungeVector({super.key, this.loungeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white
            ),
          ),
          const SizedBox(width: 2,),

          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 10,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white
                ),
              ),

              // Table Vector
              Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white
                ),
                child: Center(
                  child: Text(
                    loungeId!
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


class SeatVector extends StatelessWidget {
  const SeatVector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7)
      ),
    );
  }
}

class TableVector extends StatelessWidget {
  final String? roomId;
  const TableVector({super.key, this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white
      ),
      child: Center(
        child: Text(
          roomId ?? 'R-001'
        ),
      ),
    );
  }
}


class SeatVectoVertical extends StatelessWidget {
  const SeatVectoVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7)
      ),
    );
  }
}

class TableVectorVertical extends StatelessWidget {
  final String? roomId;
  const TableVectorVertical({super.key, this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white
      ),
      child: Center(
        child: Text(
          roomId ?? 'R-001'
        ),
      ),
    );
  }
}