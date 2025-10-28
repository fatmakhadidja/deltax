import 'dart:io';
import 'package:deltax/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class Reservation {
  final String title;
  String status; //  plus "final" pour pouvoir être modifié
  final DateTime date;
  final String location;
  final int places;

  Reservation({
    required this.title,
    required this.status,
    required this.date,
    required this.location,
    required this.places,
  });
}

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback? onDetailsPressed;
  final VoidCallback? onPaymentProofPressed;
  final void Function(String newStatus)? onStatusChanged; //  callback ajouté

  const ReservationCard({
    super.key,
    required this.reservation,
    this.onDetailsPressed,
    this.onPaymentProofPressed,
    this.onStatusChanged,
  });

  String _monthName(int month) {
    const months = [
      "janvier",
      "février",
      "mars",
      "avril",
      "mai",
      "juin",
      "juillet",
      "août",
      "septembre",
      "octobre",
      "novembre",
      "décembre",
    ];
    return months[month - 1];
  }

  Map<String, dynamic> _statusStyle(String status) {
    switch (status.toLowerCase()) {
      case "confirmée":
        return {
          "color": Colors.green[100],
          "textColor": Colors.green[700],
          "buttonText": "Preuve de paiement",
          "buttonColor": Colors.cyan,
          "buttonEnabled": true,
        };
      case "en attente":
        return {
          "color": Colors.orange[100],
          "textColor": Colors.orange[700],
          "buttonText": "Confirmer Paiement",
          "buttonColor": Colors.cyan,
          "buttonEnabled": true,
        };
      case "paiement envoyé":
        return {
          "color": Colors.grey[300],
          "textColor": const Color.fromARGB(255, 97, 97, 97),
          "buttonText": "Paiement envoyé",
          "buttonColor": Colors.grey[400],
          "buttonEnabled": false,
        };
      case "annulée":
        return {
          "color": Colors.red[100],
          "textColor": Colors.red[700],
          "buttonText": "Paiement refusé",
          "buttonColor": Colors.grey[400],
          "buttonEnabled": false,
        };
      case "terminée":
        return {
          "color": Colors.grey[200],
          "textColor": Colors.grey[600],
          "buttonText": "Expirée",
          "buttonColor": Colors.grey[400],
          "buttonEnabled": false,
        };
      default:
        return {
          "color": Colors.blue[100],
          "textColor": Colors.blue[700],
          "buttonText": "Inconnu",
          "buttonColor": Colors.grey[400],
          "buttonEnabled": false,
        };
    }
  }

  void _showPaymentDialog(BuildContext context, Reservation r) {
    FilePickerResult? pickedFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                "Confirmation de Paiement",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${r.date.day} ${_monthName(r.date.month)} ${r.date.year} - ${r.places} place(s)",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Preuve de paiement",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png', 'pdf'],
                      );
                      if (result != null) {
                        setState(() => pickedFile = result);
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                      pickedFile == null
                          ? "Choisir un fichier"
                          : pickedFile!.files.single.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Formats acceptés : Images (JPG, PNG) ou PDF",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: pickedFile == null
                      ? null
                      : () {
                          Navigator.of(context).pop();

                          //  Mise à jour du statut
                          if (onStatusChanged != null) {
                            onStatusChanged!("Paiement envoyé");
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Preuve de paiement envoyée !"),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Envoyer"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showPaymentProofDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Preuve de paiement",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/deltax_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Voici la preuve de paiement associée à votre réservation.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton.icon(
              onPressed: () async {
                try {
                  if (await Permission.storage.isDenied) {
                    await Permission.storage.request();
                  }

                  if (await Permission.manageExternalStorage.isDenied) {
                    await Permission.manageExternalStorage.request();
                  }

                  if (!await Permission.storage.isGranted &&
                      !await Permission.manageExternalStorage.isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Permission de stockage refusée."),
                      ),
                    );
                    return;
                  }

                  final byteData = await rootBundle.load(
                    'assets/images/deltax_logo.png',
                  );

                  final directory = await getDownloadsDirectory();
                  final savePath =
                      "${directory!.path}/preuve_paiement_${DateTime.now().millisecondsSinceEpoch}.png";

                  final file = File(savePath);
                  await file.writeAsBytes(byteData.buffer.asUint8List());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(" Image enregistrée : $savePath")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Erreur lors de l'enregistrement : $e"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.download),
              label: const Text("Télécharger"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              child: const Text(
                "Annuler",
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = reservation;
    final style = _statusStyle(r.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.event, color: Colors.black87),
                  const SizedBox(width: 6),
                  Text(
                    r.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: style["color"],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  r.status,
                  style: TextStyle(
                    color: style["textColor"],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Text(
                "${r.date.day} ${_monthName(r.date.month)} ${r.date.year} - ${r.date.hour.toString().padLeft(2, '0')}:${r.date.minute.toString().padLeft(2, '0')}:00",
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Text(r.location, style: const TextStyle(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.people_alt_outlined,
                  size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Text("${r.places} place(s)"),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                onPressed: onDetailsPressed,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Détails"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: style["buttonText"] == "Confirmer Paiement"
                      ? () => _showPaymentDialog(context, reservation)
                      : style["buttonText"] == "Preuve de paiement"
                          ? () => _showPaymentProofDialog(context)
                          : null,
                  icon: const Icon(Icons.receipt_long, color: Colors.white),
                  label: Text(style["buttonText"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: style["buttonColor"],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
