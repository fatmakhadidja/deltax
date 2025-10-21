import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:deltax/ui/widgets/email_text_form.dart';
import 'package:deltax/ui/widgets/name_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Merci ! Votre message a été envoyé.')),
      );
      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Coordinates (example from your screenshot)
    const LatLng deltaXLocation = LatLng(36.7525, 3.0420); // Boumerdès/Alger area

    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      appBar: AppBar(
        title: const Text('Contactez-nous'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vous avez une question ?',
              style: AppTextStyles.heading1(
                color: AppColors.darkGrey,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Nous sommes à votre écoute. Envoyez-nous un message ou utilisez les coordonnées ci-dessous.',
              style: AppTextStyles.body1(
                color: AppColors.darkGrey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),

            // --- Contact Info Card ---
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.location_on, color: AppColors.orange),
                      title: Text('Adresse'),
                      subtitle: Text('Cité 11 Décembre, Boumerdès, Algérie'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: AppColors.orange),
                      title: Text('Email'),
                      subtitle: Text('contact@deltax-dz.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: AppColors.orange),
                      title: Text('Téléphone'),
                      subtitle: Text('+213 770 00 63 54'),
                    ),
                  ],
                ),
              ),
            ),

            // --- OpenStreetMap Section ---
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: deltaXLocation,
                    initialZoom: 15.5,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.deltax.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: deltaXLocation,
                          width: 60,
                          height: 60,
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            Icons.location_pin,
                            size: 45,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- Contact Form ---
            Form(
              key: _formKey,
              child: Column(
                children: [
                  NameTextForm(
                    controller: _nameController,
                    label: "Nom",
                    hint: "Entrez votre nom complet",
                  ),
                  const SizedBox(height: 16),
                  EmailTextForm(controller: _emailController),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Message",
                              style: AppTextStyles.body1(
                                color: AppColors.darkGrey,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: " *",
                              style: AppTextStyles.body1(
                                color: AppColors.pink,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      hintText: "Entrez votre message",
                      hintStyle: AppTextStyles.body1(
                        color: AppColors.lightGrey,
                        fontSize: 14,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.darkGrey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.orange, width: 1.7),
                      ),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Veuillez saisir votre message'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      child: "Envoyer message",
                      onPressed: _submitForm,
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
