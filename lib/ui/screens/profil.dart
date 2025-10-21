import 'package:deltax/routes/routes.dart';
import 'package:deltax/ui/widgets/name_text_form.dart';
import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  late TextEditingController prenomCtrl;
  late TextEditingController nomCtrl;
  late TextEditingController usernameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController adresseCtrl;

  final List<Color> colors = [
    AppColors.orange,
    AppColors.pink,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    prenomCtrl = TextEditingController(text: "Walid");
    nomCtrl = TextEditingController(text: "Boufroune");
    usernameCtrl = TextEditingController(text: "boufrounewalid@gmail.com");
    emailCtrl = TextEditingController(text: "boufrounewalid@gmail.com");
    phoneCtrl = TextEditingController(text: "0558629858");
    adresseCtrl = TextEditingController(text: "Bordj El Kiffan, Alger");
  }

  @override
  void dispose() {
    prenomCtrl.dispose();
    nomCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    adresseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Déclare-les en haut du State

    final int charCode = usernameCtrl.text.isNotEmpty
        ? usernameCtrl.text[0].toUpperCase().codeUnitAt(0)
        : 65; // 'A' = 65
    final int colorIndex = charCode % colors.length; // modulo to stay in range
    final Color avatarColor = colors[colorIndex];

    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Column(
                    children: [
                      // Profile avatar
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: _imageFile == null
                                ? avatarColor
                                : null,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,

                            child: _imageFile == null
                                ? Text(
                                    usernameCtrl.text.isNotEmpty
                                        ? usernameCtrl.text[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImageFromGallery, //  ouvre la galerie
                              child: const CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Email
                      Text(
                        emailCtrl.text,
                        style: AppTextStyles.heading2(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        usernameCtrl.text,
                        style: AppTextStyles.body1(fontSize: 14),
                      ),

                      const SizedBox(height: 25),

                      // Role
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_rounded,
                            size: 18,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Administrateur Partenaire",
                            style: AppTextStyles.body1(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Member since
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Membre depuis 31/07/2025",
                            style: AppTextStyles.body1(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Modify password button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.changePassword,
                            );
                          },
                          icon: const Icon(Icons.key, size: 18),
                          label: const Text("Modifier Mot de Passe"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.darkGrey,
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // personal informations card
                const SizedBox(height: 20),

                // Informations personnelles card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informations personnelles",
                        style: AppTextStyles.heading2(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Prénom
                      NameTextForm(
                        controller: prenomCtrl,
                        label: "Prénom",
                        hint: "Entrez votre prénom",
                        value: prenomCtrl.text,
                      ),
                      const SizedBox(height: 15),

                      // Nom
                      NameTextForm(
                        controller: nomCtrl,
                        label: "Nom",
                        hint: "Entrez votre nom",
                      ),
                      const SizedBox(height: 15),

                      // Nom d'utilisateur
                      NameTextForm(
                        controller: usernameCtrl,
                        label: "Nom d'utilisateur",
                        hint: "Entrez votre nom d'utilisateur",
                        value: usernameCtrl.text,
                      ),
                      const SizedBox(height: 15),

                      // Email (non modifiable)
                      TextField(
                        controller: emailCtrl,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "L'email ne peut pas être modifié",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),

                      // Téléphone
                      NameTextForm(
                        controller: phoneCtrl,
                        label: "Téléphone",
                        hint: "Entrez votre numéro de téléphone",
                      ),
                      const SizedBox(height: 15),

                      // Adresse
                      NameTextForm(
                        controller: adresseCtrl,
                        label: "Adresse",
                        hint: "Entrez votre adresse",
                      ),

                      const SizedBox(height: 20),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: // Save button with gradient background
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.pink, // orange clair
                                AppColors.orange, // orange foncé
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Modifications enregistrées avec succès !",
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Enregistrer les modifications"),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // important
                              shadowColor: Colors
                                  .transparent, // enlève l'ombre du bouton
                              foregroundColor:
                                  Colors.white, // couleur du texte et icône
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
