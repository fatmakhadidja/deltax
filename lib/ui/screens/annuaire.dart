import 'package:deltax/core/const/colors.dart';
import 'package:deltax/ui/widgets/partnerCard.dart';
import 'package:flutter/material.dart';

class Annuaire extends StatefulWidget {
  const Annuaire({super.key});

  @override
  State<Annuaire> createState() => _AnnuaireState();
}

class _AnnuaireState extends State<Annuaire> {
  final List<Map<String, String>> partners = [
    {
      'name': 'Hippon Sky',
      'wilaya': 'Annaba',
      'category': 'Parapente',
      'description':
          'Club Hippon Sky – L’aventure commence dans le ciel sous la direction de Sofiane, passionné et pilote expérimenté.',
      'image': 'assets/images/diving.jpg',
      'facebook': 'https://deltax-dz.com/annuaire',
      'instagram': 'https://deltax-dz.com/annuaire',
      'tiktok': 'https://www.tiktok.com/@hipponsky',
      'website': 'https://hipponsky.com',
    },
    {
      'name': 'Sky 35',
      'wilaya': 'Boumerdès',
      'category': 'Parapente',
      'description':
          'Touchez le ciel, vivez la liberté ! Oubliez la terre ferme et laissez-vous porter par le vent !',
      'image': 'assets/images/diving.jpg',
      'facebook': 'https://www.facebook.com/sky35club',
      'instagram': 'https://www.instagram.com/sky35club',
      'tiktok': '',
      'website': '',
    },
    {
      'name': 'Gouraya Trek',
      'wilaya': 'Béjaïa',
      'category': 'Randonnée',
      'description':
          'Randonnées guidées dans le parc national de Gouraya pour découvrir la beauté de la nature.',
      'image': 'assets/images/diving.jpg',
      'facebook': 'https://www.facebook.com/gourayatrek',
      'instagram': 'https://www.instagram.com/gourayatrek',
      'tiktok': '',
      'website': 'https://gourayatrek.com',
    },
    {
      'name': 'Cap Kayak',
      'wilaya': 'Tizi Ouzou',
      'category': 'Kayak',
      'description':
          'Découvrez la côte de Tigzirt autrement ! Cap Kayak propose des balades et des formations nautiques pour tous les niveaux.',
      'image': 'assets/images/diving.jpg',
      'facebook': 'https://www.facebook.com/capkayakdz',
      'instagram': 'https://www.instagram.com/capkayakdz',
      'tiktok': 'https://www.tiktok.com/@capkayakdz',
      'website': '',
    },
    {
      'name': 'Djurdjura Escalade',
      'wilaya': 'Bouira',
      'category': 'Escalade',
      'description':
          'Encadré par des moniteurs expérimentés, Djurdjura Escalade vous emmène sur les plus beaux rochers du massif.',
      'image': 'assets/images/diving.jpg',
      'facebook': 'https://www.facebook.com/djurdjuraescalade',
      'instagram': 'https://www.instagram.com/djurdjuraescalade',
      'tiktok': '',
      'website': '',
    },
  ];

  String selectedCategory = "Toutes les catégories";
  String selectedWilaya = "Toutes les wilayas";
  String searchQuery = "";

  final List<String> categories = [
    "Toutes les catégories",
    "Parapente",
    "Randonnée",
    "Kayak",
    "Escalade",
  ];

  final List<String> wilayas = [
    "Toutes les wilayas",
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

  List<Map<String, String>> get filteredPartners {
    return partners.where((p) {
      final matchesSearch =
          p['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p['description']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p['wilaya']!.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCategory =
          (selectedCategory == "Toutes les catégories") ||
          p['category'] == selectedCategory;

      final matchesWilaya =
          (selectedWilaya == "Toutes les wilayas") ||
          p['wilaya'] == selectedWilaya.split(' - ').last.trim();

      return matchesSearch && matchesCategory && matchesWilaya;
    }).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final visiblePartners = filteredPartners;

    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
       appBar: AppBar(
        title: const Text('Annuaire'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notre Réseau de Partenaires",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Découvrez les professionnels et les établissements qui font vivre l’aventure.",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),

              //  Filtre wilaya
              DropdownButtonFormField<String>(
                value: selectedWilaya,
                menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
                isExpanded: true,
                items: wilayas
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => selectedWilaya = val!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //  Liste des partenaires
              Expanded(
                child: visiblePartners.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucun partenaire trouvé.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: visiblePartners.length,
                        itemBuilder: (context, index) {
                          final partner = visiblePartners[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: PartnerCard(
                              name: partner['name']!,
                              wilaya: partner['wilaya']!,
                              description: partner['description']!,
                              imageUrl: partner['image']!,
                              facebook: partner['facebook'],
                              instagram: partner['instagram'],
                              tiktok: partner['tiktok'],
                              website: partner['website'],
                            ),
                          );
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
