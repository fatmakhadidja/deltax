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

  const EvenementBox({
    super.key,
    required this.imageUrl,
    required this.titre,
    required this.date,
    required this.duree,
    required this.lieu,
    required this.categorie,
    required this.prix,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy', 'fr_FR');
    final heureFormat = DateFormat('HH:mm', 'fr_FR');

    // Vérifie si l’événement est passé
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
              //  Image + superpositions
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

                  //  Badge “À la une”
                ],
              ),

              const SizedBox(height: 10),

              //  Contenu principal
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

                    // Date & Heure
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

                    const SizedBox(height: 10),

                    // Bouton Détails
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
          //  Ruban "Terminé"
          if (isPast)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          if (isPast)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomPaint(
                  painter: _RibbonPainter(color: Colors.redAccent),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Terminé',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Peint un ruban triangulaire à gauche
class _RibbonPainter extends CustomPainter {
  final Color color;

  _RibbonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 20, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RibbonPainter oldDelegate) => false;
}
