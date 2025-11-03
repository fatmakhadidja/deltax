import 'package:carousel_slider/carousel_slider.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/core/providers/navigationProvider.dart';
import 'package:deltax/ui/widgets/evenement_box.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> _activities = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final imagePaths = [
        'assets/images/ski.jpg',
        'assets/images/diving.jpg',
        'assets/images/randonnee.jpg',
        'assets/images/safari.jpg',
      ];

      for (final path in imagePaths) {
        await precacheImage(AssetImage(path), context);
      }

      if (mounted) {
        setState(() => _isInitialized = true);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _activities = [
      {
        'image': const AssetImage('assets/images/ski.jpg'),
        'title': 'Ski',
        'description':
            "Vivez l’hiver autrement avec DeltaX ! Entre descentes vertigineuses et paysages enneigés...",
      },
      {
        'image': const AssetImage('assets/images/diving.jpg'),
        'title': 'Plongée sous-marine',
        'description': "Avec DeltaX, explorez un monde sous-marin caché...",
      },
      {
        'image': const AssetImage('assets/images/randonnee.jpg'),
        'title': 'Randonnée',
        'description':
            "Découvrez la beauté naturelle de l’Algérie à travers nos randonnées organisées...",
      },
      {
        'image': const AssetImage('assets/images/safari.jpg'),
        'title': 'Safari',
        'description':
            "Partez à la découverte des grands espaces algériens avec nos safaris en 4x4...",
      },
    ];
  }

  // Exemple d’événements (tu pourras ensuite les charger depuis un provider)
  final List<Map<String, dynamic>> _allEvents = [
   {
      'titre': 'Tandem en parapente',
      'image': 'assets/images/diving.jpg',
      'date': DateTime(2025, 10, 10, 8, 0, 0),
      'duree': const Duration(hours: 8),
      'lieu': 'Plage Kadous, Aïn Taya, Alger',
      'categorie': 'Parapente',
      'partenaire': 'SkyTeam',
      'wilaya': 'Alger',
      'prix': 6000,
      'enVedette': true,
      'location': const LatLng(36.7934, 3.2863),
    },
    {
      'titre': 'Plongée sous-marine',
      'image': 'assets/images/diving.jpg',
      'date': DateTime(2025, 10, 14, 9, 0, 0),
      'duree': const Duration(hours: 6),
      'lieu': 'Plage de Zéralda, Alger',
      'categorie': 'Plongée',
      'partenaire': 'AquaLife',
      'wilaya': 'Alger',
      'prix': 8500,
      'enVedette': true,
      'location': const LatLng(36.7509, 3.0420),
    },
    {
      'titre': 'Randonnée dans le Djurdjura',
      'image': 'assets/images/diving.jpg',
      'date': DateTime(2025, 10, 18, 7, 0, 0),
      'duree': const Duration(hours: 10),
      'lieu': 'Mont Djurdjura, Kabylie',
      'categorie': 'Randonnée',
      'partenaire': 'Club Aventure',
      'wilaya': 'Tizi Ouzou',
      'prix': 5000,
      'enVedette': false,
      'location': const LatLng(36.4800, 4.0667),
    },
    {
      'titre': 'Kayak à Cap Djinet',
      'image': 'assets/images/diving.jpg',
      'date': DateTime(2025, 10, 22, 8, 0, 0),
      'duree': const Duration(hours: 5),
      'lieu': 'Cap Djinet, Boumerdès',
      'categorie': 'Kayak',
      'partenaire': 'AquaLife',
      'wilaya': 'Boumerdès',
      'prix': 7000,
      'enVedette': false,
      'location': const LatLng(36.8700, 3.7400),
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
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              items: _activities.map((activity) {
                return Stack(
                  alignment: Alignment.bottomCenter,

                  children: [
                    // Uses DecorationImage with preloaded AssetImage
                    FadeInImage(
                      placeholder: const AssetImage(
                        'assets/images/placeholder.jpg',
                      ),
                      image: activity['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fadeInDuration: const Duration(milliseconds: 400),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ), // Text overlay
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            activity['title'],
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            activity['description'],
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
                          location : event['location'],
                      imageUrl: event['image'],
                      titre: event['titre'],
                      date: event['date'],
                      duree: event['duree'],
                      lieu: event['lieu'],
                      categorie: event['categorie'],
                      prix: event['prix'],
                      partenaire: event['partenaire'],
                      partenaireDescription:
                          'Organisé par ${event['partenaire']}, profitez de cette expérience unique à ${event['lieu']}.',
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
