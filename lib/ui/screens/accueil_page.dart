import 'package:carousel_slider/carousel_slider.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/core/providers/navigationProvider.dart';

import 'package:deltax/ui/widgets/evenement_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _currentIndex = 0;

  List<Image> images = [];
  List<Map<String, dynamic>> _activities = [];

  initState() {
    super.initState();
    images = [
      Image.asset(
        'assets/images/ski.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
      ),
      Image.asset(
        'assets/images/diving.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
      ),
      Image.asset(
        'assets/images/randonnee.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
      ),
      Image.asset(
        'assets/images/safari.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
      ),
    ];

    _activities = [
      {
        'image': images[0],
        'title': 'Ski',
        'description':
            "Vivez l’hiver autrement avec DeltaX ! Entre descentes vertigineuses et paysages enneigés, nos aventures hivernales vous offrent une expérience unique, encadrée par des professionnels et riche en sensations fortes.",
      },
      {
        'image': images[1],
        'title': 'Plongée sous-marine',
        'description':
            "Avec DeltaX, explorez un monde sous-marin caché. Encadré par des professionnels, partez à la découverte de récifs colorés et d’une faune fascinante — accessible à tous, débutants comme passionnés.",
      },
      {
        'image': images[2],
        'title': 'Randonnée',
        'description':
            "Découvrez la beauté naturelle de l’Algérie à travers nos randonnées organisées, entre montagnes, forêts et villages authentiques.",
      },
      {
        'image': images[3],
        'title': 'Safari',
        'description':
            "Partez à la découverte des grands espaces algériens avec nos safaris en 4x4. Entre dunes dorées, paysages sahariens et bivouacs sous les étoiles, vivez une aventure authentique et inoubliable.",
      },
    ];
  }

  ///  Exemple d’événements (tu pourras ensuite les charger depuis un provider)
  final List<Map<String, dynamic>> _allEvents = [
    {
      'image': 'assets/images/diving.jpg',
      'titre': 'Randonnée à Tikjda',
      'date': DateTime(2025, 11, 10, 8, 30),
      'duree': const Duration(hours: 6, minutes: 30),
      'lieu': 'Bouira',
      'categorie': 'Nature',
      'prix': 2500,
      'enVedette': true,
    },
    {
      'image': 'assets/images/diving.jpg',
      'titre': 'Plongée à Béjaïa',
      'date': DateTime(2025, 10, 15, 9, 0),
      'duree': const Duration(hours: 4),
      'lieu': 'Béjaïa',
      'categorie': 'Mer',
      'prix': 4000,
      'enVedette': false,
    },
    {
      'image': 'assets/images/diving.jpg',
      'titre': 'Ski à Chréa',
      'date': DateTime(2025, 12, 20, 7, 0),
      'duree': const Duration(hours: 5),
      'lieu': 'Blida',
      'categorie': 'Montagne',
      'prix': 5000,
      'enVedette': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrer uniquement les événements à venir
    final List<Map<String, dynamic>> upcomingEvents =
        _allEvents
            .where((event) => event['date'].isAfter(DateTime.now()))
            .toList()
          ..sort((a, b) => a['date'].compareTo(b['date']));

    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ====== CAROUSEL SECTION ======
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.4,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              items: _activities.map((activity) {
                return Builder(
                  builder: (context) => Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(child: activity['image']),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              activity['title']!,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              activity['description']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // ====== UPCOMING EVENTS SECTION ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Text(
                    "Événements à venir",
                    style: AppTextStyles.heading1(color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Container(height: 3, width: 60, color: AppColors.pink),
                  const SizedBox(height: 20),

                  if (upcomingEvents.isEmpty)
                    Text(
                      "Aucun événement à venir pour le moment.",
                      style: AppTextStyles.body1(color: Colors.black),
                    )
                  else
                    Column(
                      children: upcomingEvents.map((event) {
                        return EvenementBox(
                          imageUrl: event['image'],
                          titre: event['titre'],
                          date: event['date'],
                          duree: event['duree'],
                          lieu: event['lieu'],
                          categorie: event['categorie'],
                          prix: event['prix'],
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<NavigationProvider>(
                        context,
                        listen: false,
                      ).setIndex(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Voir tous les événements",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
