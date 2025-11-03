import 'package:deltax/ui/screens/evenement_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../core/const/colors.dart';

class EvenementBox extends StatelessWidget {
  final String imageUrl;
  final String titre;
  final DateTime date;
  final Duration duree;
  final String lieu;
  final String categorie;
  final int prix;
  final String partenaire;
  final String partenaireDescription;
  final LatLng location;

  const EvenementBox({
    super.key,
    required this.imageUrl,
    required this.titre,
    required this.date,
    required this.duree,
    required this.lieu,
    required this.categorie,
    required this.prix,
    required this.partenaire,
    required this.partenaireDescription,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy', 'fr_FR');
    final heureFormat = DateFormat('HH:mm', 'fr_FR');
    final bool isPast = date.isBefore(DateTime.now());

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titre,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.pink,
                        ),
                        const SizedBox(width: 6),
                        Text(dateFormat.format(date)),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.pink,
                        ),
                        const SizedBox(width: 4),
                        Text(heureFormat.format(date)),
                      ],
                    ),
                    const SizedBox(height: 6),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.pink,
                        ),
                        const SizedBox(width: 6),
                        Expanded(child: Text(lieu)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$prix DZD',
                      style: const TextStyle(
                        color: AppColors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EvenementDetails(
                                location: location,
                                imageUrl: imageUrl,
                                titre: titre,
                                date: date,
                                duree: duree,
                                lieu: lieu,
                                prix: prix,
                                partenaire: partenaire,
                                partenaireDescription: partenaireDescription,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Détails',
                          style: TextStyle(color: AppColors.darkGrey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isPast)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          if (isPast)
            const Positioned(
              top: 8,
              left: 8,
              child: Chip(
                label: Text(
                  'Terminé',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.redAccent,
              ),
            ),
        ],
      ),
    );
  }
}
