import 'package:flutter/material.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class NewsContainer extends StatelessWidget {
  final String? image;
  final String? imageUrl;
  final String? header;
  final String? account;
  final String? message;
  final String? uploadImage;
  final String? comments;
  final String? likes;
  final String? views;
  const NewsContainer({super.key, this.image, this.account, this.header, this.message, this.uploadImage, this.comments, this.likes, this.views, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Image.asset(
              image ?? 'assets/images/google.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 10,),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header ?? 'Library Admin',
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 0,),
            
                Text(
                  account ?? 'admin@email.com',
                  style: const TextStyle(
                    color: MainColors.greyTextColor,
                    fontSize: 13
                  ),
                ),
            
                const SizedBox(height: 6,),
            
                // Information
                Text(
                  message ?? 'Welcome! \nUnlock a world of knowledge with our online library booking app! Reserve your favorites, and embark on a literary adventure like never before. Start exploring now!',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                ),

                const SizedBox(height: 10,),

                if (imageUrl != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  // color: Colors.amber,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imageUrl ?? '',
                      fit: BoxFit.contain,
                      height: 300,
                      width: double.infinity,
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.message_outlined, size: 15,),
                          const SizedBox(width: 2,),
                          Text(
                            comments ?? '100',
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_border_outlined, size: 15,),
                          const SizedBox(width: 2,),
                          Text(
                            comments ?? '100',
                            style: const TextStyle(
                              fontSize: 12.5,
                            ),
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.visibility_outlined, size: 15,),
                          const SizedBox(width: 2,),
                          Text(
                            comments ?? '100',
                            style: const TextStyle(
                              fontSize: 12.5,
                            ),
                          )
                        ],
                      ),
                    ),

                    const Expanded(
                      child: Icon(Icons.copy, size: 14,),
                    ),

                    const Expanded(
                      child: Icon(Icons.share_outlined, size: 14,),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}