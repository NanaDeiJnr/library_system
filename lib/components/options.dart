import 'package:flutter/material.dart';

class OptionsContainer extends StatelessWidget {
  final String? title;
  final Widget? icon;
  const OptionsContainer({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      // color: Colors.amber,
      child: Row(
        children: [
          icon ?? const Icon(Icons.error),
          const SizedBox(width: 20,),
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: 17
            ),
          )
        ],
      ),
    );
  }
}