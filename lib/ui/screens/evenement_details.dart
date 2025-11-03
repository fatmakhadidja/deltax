import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../../core/const/colors.dart';

class EvenementDetails extends StatelessWidget {
  final String imageUrl;
  final String titre;
  final DateTime date;
  final Duration duree;
  final String lieu;
  final int prix;
  final String partenaire;
  final String partenaireDescription;
  final LatLng location;

  const EvenementDetails({
    super.key,
    required this.imageUrl,
    required this.titre,
    required this.date,
    required this.duree,
    required this.lieu,
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

    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      appBar: AppBar(title: Text(titre), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imageUrl, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppColors.pink,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(dateFormat.format(date)),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.access_time,
                        color: AppColors.pink,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(heureFormat.format(date)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.timelapse,
                        color: AppColors.pink,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${duree.inHours}h${(duree.inMinutes % 60).toString().padLeft(2, '0')}min',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.pink,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(lieu),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$prix DZD',
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isPast)
                    const Chip(
                      label: Text(
                        'Événement passé',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),

                  const SizedBox(height: 25),

                  // Carte intégrée
                  const Text(
                    'Localisation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: location,
                        initialZoom: 12.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                          userAgentPackageName: 'com.example.deltax',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: location,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'À propos de cet événement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sky35 propose à ses clients une aventure familiale de parapente à Cap Djennat.',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),

                  const SizedBox(height: 25),
                  const Text(
                    'Organisé par',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partenaire,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              partenaireDescription,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Réserver votre place",
                            style: AppTextStyles.heading1(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Réserver votre place",
                            style: AppTextStyles.body1(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Vous avez réservé 2 places",
                            style: AppTextStyles.body1(
                              color: AppColors.success,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (date.isAfter(
                                DateTime.now(),
                              )) 
                                MyButton(
                                  child: "Réserver ta place",
                                  onPressed: () {
                                    // ton action ici
                                  },
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Événement déjà passé",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
