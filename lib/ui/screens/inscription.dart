import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/screenSize.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/routes/routes.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:deltax/ui/widgets/confirm_password_text_form.dart';
import 'package:deltax/ui/widgets/email_text_form.dart';
import 'package:deltax/ui/widgets/name_text_form.dart';
import 'package:deltax/ui/widgets/password_text_form.dart';
import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController nomUtilisateurCtrl = TextEditingController();
  TextEditingController nomCtrl = TextEditingController();
  TextEditingController prenomCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF416C), Color(0xFFFF4B2C)], // 2 colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/deltax_logo.png"),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        width: ScreenSize(context).width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Inscription", style: AppTextStyles.heading1()),
                            SizedBox(height: 5),
                            Text(
                              "Rejoignez-nous pour accéder à tous nos services",
                              style: AppTextStyles.body1(color: AppColors.darkGrey),
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NameTextForm(
                                    controller: nomUtilisateurCtrl,
                                    hint: "Entrez votre nom d'utilisateur",
                                    label: "Nom d'utilisateur",
                                  ),
                                  SizedBox(height: 25),
                                  EmailTextForm(controller: emailCtrl),
                  
                                  SizedBox(height: 25),
                                  NameTextForm(
                                    controller: prenomCtrl,
                                    hint: "Entrez votre nom prénom",
                                    label: "Prénom",
                                  ),
                                  SizedBox(height: 25),
                                  NameTextForm(
                                    controller: nomCtrl,
                                    hint: "Entrez votre nom",
                                    label: "Nom",
                                  ),
                                  SizedBox(height: 25),
                                  PasswordTextForm(
                                    label: "Mot de passe",
                                    controller: passwordCtrl,
                                  ),
                                  SizedBox(height: 25),
                                  ConfirmPasswordTextForm(
                                    label: "Confirmer le mot de passe",
                                    controller: confirmPasswordCtrl,
                                    firstPassword: passwordCtrl,
                                  ),
                                ],
                              ),
                            ),
                  
                            SizedBox(height: 20),
                            MyButton(
                              child: "Inscrire",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("Form is valid!");
                                } else {
                                  print("Form is invalid!");
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Vous avez déjà un compte?",
                                  style: AppTextStyles.body1(color: Colors.black),
                                ),
                  
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Se connecter",
                                    style: AppTextStyles.body1(
                                      color: AppColors.orange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: ScreenSize(context).width * 0.3,
                                  height: 1,
                                  color: AppColors.lightLightGrey, // line color
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Ou",
                                  style: AppTextStyles.body1(
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  width: ScreenSize(context).width * 0.3,
                                  height: 1,
                                  color: AppColors.lightLightGrey, // line color
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Vous êtes un professionnel ?",
                                  style: AppTextStyles.body1(color: Colors.black),
                                ),
                  
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                      EdgeInsets.all(3),
                                    ),
                                    minimumSize: WidgetStateProperty.all(Size.zero),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    "Inscrivez votre établissement",
                                    style: AppTextStyles.body1(
                                      color: AppColors.orange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
