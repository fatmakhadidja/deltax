import 'package:deltax/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EvenementBox extends StatelessWidget {
  final String imageUrl;
  final String titre;
  final DateTime date;
  final Duration duree;
  final String lieu;
  final String categorie;
  final int prix;
  final bool enVedette;

  const EvenementBox({
    super.key,
    required this.imageUrl,
    required this.titre,
    required this.date,
    required this.duree,
    required this.lieu,
    required this.categorie,
    required this.prix,
    this.enVedette = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy');
    final heureFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image avec badge "À la une"
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (enVedette)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'À la une',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          // Contenu principal
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et catégorie
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        titre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        categorie,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Informations de date et heure
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.pink,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      dateFormat.format(date),
                      style: const TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.pink,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      heureFormat.format(date),
                      style: const TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Durée
                Row(
                  children: [
                    const Icon(
                      Icons.timelapse,
                      size: 16,
                      color: AppColors.pink,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${duree.inHours}h${(duree.inMinutes % 60).toString().padLeft(2, '0')}min',
                      style: const TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Lieu
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.pink,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        lieu,
                        style: const TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Prix
                Text(
                  '$prix DZD',
                  style: const TextStyle(
                    color: AppColors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.darkGrey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    child: const Text(
                      'Détails',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
