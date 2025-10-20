import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;

  const NotificationItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar image
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(imageUrl),
            backgroundColor: AppColors.lightGrey,
          ),
          const SizedBox(width: 12),

          // Title + content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading2(color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: AppTextStyles.body1(color: AppColors.darkGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
