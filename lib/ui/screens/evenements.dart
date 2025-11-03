import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/evenement_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

class Evenements extends StatefulWidget {
  const Evenements({super.key});

  @override
  State<Evenements> createState() => _EvenementsState();
}

class _EvenementsState extends State<Evenements> {
  final PopupController _popupLayerController = PopupController();

  // Liste complète des événements
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

  // Valeurs actuelles des filtres
  String _selectedCategorie = "Toutes";
  String _selectedPartenaire = "Tous";
  String _selectedWilaya = "Toutes";

  // Listes d'options
  final List<String> _categories = [
    "Toutes",
    "Randonnée",
    "Kayak",
    "Plongée",
    "Parapente",
  ];
  final List<String> _partenaires = [
    "Tous",
    "Club Aventure",
    "AquaLife",
    "SkyTeam",
  ];
  final List<String> _wilayas = [
    "Toutes",
    "01 - Adrar",
    "02 - Chlef",
    "03 - Laghouat",
    "04 - Oum El Bouaghi",
    "05 - Batna",
    "06 - Béjaïa",
    "07 - Biskra",
    "08 - Béchar",
    "09 - Blida",
    "10 - Bouira",
    "11 - Tamanrasset",
    "12 - Tébessa",
    "13 - Tlemcen",
    "14 - Tiaret",
    "15 - Tizi Ouzou",
    "16 - Alger",
    "17 - Djelfa",
    "18 - Jijel",
    "19 - Sétif",
    "20 - Saïda",
    "21 - Skikda",
    "22 - Sidi Bel Abbès",
    "23 - Annaba",
    "24 - Guelma",
    "25 - Constantine",
    "26 - Médéa",
    "27 - Mostaganem",
    "28 - M’Sila",
    "29 - Mascara",
    "30 - Ouargla",
    "31 - Oran",
    "32 - El Bayadh",
    "33 - Illizi",
    "34 - Bordj Bou Arréridj",
    "35 - Boumerdès",
    "36 - El Tarf",
    "37 - Tindouf",
    "38 - Tissemsilt",
    "39 - El Oued",
    "40 - Khenchela",
    "41 - Souk Ahras",
    "42 - Tipaza",
    "43 - Mila",
    "44 - Aïn Defla",
    "45 - Naâma",
    "46 - Aïn Témouchent",
    "47 - Ghardaïa",
    "48 - Relizane",
    "49 - El M’Ghair",
    "50 - El Meniaa",
    "51 - Ouled Djellal",
    "52 - Bordj Badji Mokhtar",
    "53 - Béni Abbès",
    "54 - Timimoun",
    "55 - Touggourt",
    "56 - Djanet",
    "57 - In Salah",
    "58 - In Guezzam",
  ];

  // Liste affichée (filtrée)
  List<Map<String, dynamic>> _displayedEvents = [];

  bool _filtersApplied = false;

  @override
  void initState() {
    super.initState();
    _displayedEvents = List.from(_allEvents);
  }

  void _updateDisplayedEvents() {
    setState(() {
      final now = DateTime.now();

      _displayedEvents = _allEvents.where((event) {
        final matchCategorie =
            _selectedCategorie == "Toutes" ||
            event['categorie'] == _selectedCategorie;
        final matchPartenaire =
            _selectedPartenaire == "Tous" ||
            event['partenaire'] == _selectedPartenaire;
        final matchesWilaya =
            (_selectedWilaya == "Toutes") ||
            event['wilaya'] == _selectedWilaya.split(' - ').last.trim();
        final matchDate = !_filtersApplied || event['date'].isAfter(now);

        return matchCategorie && matchPartenaire && matchesWilaya && matchDate;
      }).toList();
    });
  }

  void _applyFilters() {
    setState(() {
      _filtersApplied = !_filtersApplied;
    });
    _updateDisplayedEvents();
  }

  // Afficher la carte
  void _showMapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 420,
              width: double.infinity,
              child: Stack(
                children: [
                  _buildMap(),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Carte
  Widget _buildMap() {
    final center = LatLng(36.75, 3.06);
    final markers = _displayedEvents.map((event) {
      return Marker(
        width: 40,
        height: 40,
        point: event['location'],
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: 8.5,
        onTap: (_, __) => _popupLayerController.hideAllPopups(),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.deltax',
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            markers: markers,
            popupController: _popupLayerController,
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) {
                final event = _displayedEvents.firstWhere(
                  (e) =>
                      (e['location'].latitude - marker.point.latitude).abs() <
                          0.0001 &&
                      (e['location'].longitude - marker.point.longitude).abs() <
                          0.0001,
                  orElse: () => {},
                );

                if (event.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Événement non trouvé"),
                    ),
                  );
                }

                return _buildPopupCard(event);
              },
            ),
          ),
        ),
      ],
    );
  }

  // Carte popup
  Widget _buildPopupCard(Map<String, dynamic> event) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event['titre'],
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              event['categorie'],
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 4),
            Text(
              "${event['prix']} DZD",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper pour chaque filtre
  Widget _buildFilterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.pink, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Nos Événements",
                  style: AppTextStyles.heading1(color: Colors.black),
                ),
                const SizedBox(height: 15),
                Text(
                  "Découvrez nos événements à venir et réservez votre place dès maintenant !",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body1(color: Colors.black),
                ),
                const SizedBox(height: 10),

                // Bouton carte
                OutlinedButton.icon(
                  onPressed: () => _showMapDialog(context),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.blue),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.map, color: Colors.blue),
                  label: Text(
                    "Voir sur la carte",
                    style: AppTextStyles.body1(color: Colors.blue),
                  ),
                ),

                // Filtres
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      _buildFilterDropdown(
                        label: "Catégorie",
                        value: _selectedCategorie,
                        items: _categories,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategorie = value!;
                            _updateDisplayedEvents();
                           
                          });
                        },
                      ),
                      _buildFilterDropdown(
                        label: "Partenaire",
                        value: _selectedPartenaire,
                        items: _partenaires,
                        onChanged: (value) {
                          setState(() {
                            _selectedPartenaire = value!;
                            _updateDisplayedEvents();
                          });
                        },
                      ),
                      _buildFilterDropdown(
                        label: "Wilaya",
                        value: _selectedWilaya,
                        items: _wilayas,
                        onChanged: (value) {
                          setState(() {
                            _selectedWilaya = value!;
                            _updateDisplayedEvents();
                          });
                        },
                      ),
                      OutlinedButton(
                        onPressed: _applyFilters,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _filtersApplied
                                ? AppColors.pink
                                : Colors.grey,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Non terminé",
                          style: TextStyle(
                            color: _filtersApplied
                                ? AppColors.pink
                                : Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Liste filtrée
                if (_displayedEvents.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Aucun événement ne correspond aux filtres."),
                  )
                else
                  ..._displayedEvents.map(
                    (event) => EvenementBox(
                      imageUrl: event['image'],
                      titre: event['titre'],
                      date: event['date'],
                      duree: event['duree'],
                      lieu: event['lieu'],
                      categorie: event['categorie'],
                      prix: event['prix'],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
