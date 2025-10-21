import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:flutter/material.dart';

class Apropos extends StatelessWidget {
  const Apropos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      appBar: AppBar(
        title: const Text('À propos de DeltaX'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qui sommes-nous ?',
              style: AppTextStyles.heading1(color: AppColors.darkGrey,fontSize: 40),
            ),
            const SizedBox(height: 12),
            const Text(
              'DeltaX est une plateforme innovante dédiée au tourisme d’aventure. '
              'Que vous soyez à la recherche de parapente, de plongée sous-marine, ou '
              'd’une activité tranquille en pleine nature, nous vous relions aux professionnels '
              'pour vivre des expériences fortes. ', // adapt wording as needed
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                            
                                            child: Image.asset(
                                              'assets/images/image.png', 
                                              fit: BoxFit.cover,
                                            ),
                                          
                            ),
                          ],
                        ),
            const SizedBox(height: 24),
            Text(
              'Notre mission',
              style: AppTextStyles.heading2(color: AppColors.darkGrey,fontSize: 30),
            ),
            const SizedBox(height: 12),
            const Text(
              'Offrir une interface simple et fiable pour explorer une large gamme d’activités d’aventure. '
              'Nous souhaitons que chaque utilisateur puisse découvrir, réserver et vivre des moments mémorables en toute confiance.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Pourquoi choisir DeltaX ?',
              style: AppTextStyles.heading1(color: AppColors.darkGrey,fontSize: 30),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Une sélection rigoureuse des prestataires\n'
              '• Une couverture variée des activités – des sensations fortes aux balades nature\n'
              '• Une équipe dédiée à vous accompagner à chaque étape de votre expérience.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Notre vision',
              style: AppTextStyles.heading1(color: AppColors.darkGrey,fontSize: 30),
            ),
            const SizedBox(height: 12),
            const Text(
              'Créer un écosystème où aventure rime avec accessibilité, sécurité et respect de l’environnement. '
              'Faisons de chaque sortie une découverte, de chaque moment un souvenir.',
              style: TextStyle(fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}
