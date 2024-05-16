// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lmsystem_app/utils/hex_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String? time;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      margin: isCurrentUser ? const EdgeInsets.only(top: 1.2, bottom: 1.2, right: 1.2, left: 40) : const EdgeInsets.only(top: 1.2, bottom: 1.2, left: 1.2, right: 40),
      decoration: BoxDecoration(
        color: isCurrentUser ? MainColors.tertiaryBgColor : MainColors.primaryColor,
        borderRadius: isCurrentUser
        ? const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(15),
        ) : const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(15)
          )
      ),
      child: isCurrentUser 
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  color: isCurrentUser ? MainColors.primaryColor : MainColors.primaryWhite,
                  fontSize: 17
                ),
              ),
            ),
            const SizedBox(width: 7,),
            Text(
              time ?? '00:00',
              style: const TextStyle(
                fontSize: 12
              ),
            )
          ],
        )
      : Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time ?? '00:00',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12
            ),
          ),
          const SizedBox(width: 7,),

          Text(
            message,
            softWrap: false,
            style: TextStyle(
              color: isCurrentUser ? MainColors.primaryColor : MainColors.primaryWhite,
              fontSize: 17
            ),
          ),
        ],
      ),
    );
  }
}
