import 'package:flutter/material.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class PrimaryChatContainer extends StatelessWidget {
  final String chatName;
  final String? time;
  final String? message;
  final String? numberOfChats;
  final String? status;
  final void Function()? onTap;

  const PrimaryChatContainer({
    super.key,
    required this.chatName,
    this.time,
    this.message,
    this.numberOfChats,
    this.status, // Added status parameter
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.grey.shade200,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: MainColors.primaryColor, // Example color
                radius: 22,
                child: Icon(Icons.people, color: Colors.white,),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        time ?? '00:00',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message ?? 'Hello World. this is a test chat. We are still working in it.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(),
                        ),
                      ),
                      const SizedBox(width: 40,),
                      if (status != null) // Display status if available
                        Text(
                          status!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Example color
                          ),
                        ),
                      if (numberOfChats != null)
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue, // Example color
                          ),
                          child: Text(
                            numberOfChats ?? '1',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
