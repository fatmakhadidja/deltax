import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/evenement_box.dart';
import 'package:flutter/material.dart';

class Evenements extends StatelessWidget {
  const Evenements({super.key});

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
                  "Nos Evenements",
                  style: AppTextStyles.heading1(color: Colors.black),
                ),
                SizedBox(height: 15),
                Text(
                  "écouvrez nos événements à venir et réservez votre place dès maintenant !",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body1(color: Colors.black),
                ),
                SizedBox(height: 10),
                EvenementBox(
                  imageUrl: 'assets/images/diving.jpg',
                  titre: 'Tandem en parapente',
                  date: DateTime(2025, 10, 10, 8, 0, 0),
                  duree: const Duration(hours: 8),
                  lieu: 'Plage Kadous, Aïn Taya, Alger',
                  categorie: 'Parapente',
                  prix: 6000,
                  enVedette: true,
                ),
                EvenementBox(
                  imageUrl: 'assets/images/diving.jpg',
                  titre: 'Tandem en parapente',
                  date: DateTime(2025, 10, 10, 8, 0, 0),
                  duree: const Duration(hours: 8),
                  lieu: 'Plage Kadous, Aïn Taya, Alger',
                  categorie: 'Parapente',
                  prix: 6000,
                  enVedette: true,
                ),
                EvenementBox(
                  imageUrl: 'assets/images/diving.jpg',
                  titre: 'Tandem en parapente',
                  date: DateTime(2025, 10, 10, 8, 0, 0),
                  duree: const Duration(hours: 8),
                  lieu: 'Plage Kadous, Aïn Taya, Alger',
                  categorie: 'Parapente',
                  prix: 6000,
                  enVedette: true,
                ),
                EvenementBox(
                  imageUrl: 'assets/images/diving.jpg',
                  titre: 'Tandem en parapente',
                  date: DateTime(2025, 10, 10, 8, 0, 0),
                  duree: const Duration(hours: 8),
                  lieu: 'Plage Kadous, Aïn Taya, Alger',
                  categorie: 'Parapente',
                  prix: 6000,
                  enVedette: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
