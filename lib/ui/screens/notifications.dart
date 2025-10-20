import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/notificationItem.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Nouveau message',
      content: 'Vous avez reçu un message de votre médecin.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    NotificationItem(
      imageUrl: 'assets/images/deltax_logo.png',
      title: 'Mise à jour',
      content: 'Votre dossier médical a été mis à jour.',
    ),
    // ... (add the rest here)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mes notifications",
                style: AppTextStyles.heading1(color: Colors.black),
              ),
              const SizedBox(height: 10),

              // Body content
              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_off,
                              size: 100,
                              color: AppColors.darkGrey,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Vous n'avez aucune notification",
                              style: AppTextStyles.heading2(
                                color: AppColors.darkGrey,
                              ),
                            ),
                            Text(
                              "Les nouvelles notifications apparaitront ici",
                              style: AppTextStyles.heading2(
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return notifications[index];
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
