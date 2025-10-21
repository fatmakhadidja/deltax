import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/screenSize.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:deltax/ui/widgets/email_text_form.dart';
import 'package:deltax/ui/widgets/googleButton.dart';
import 'package:deltax/ui/widgets/password_text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deltax/core/providers/user_provider.dart';
class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
              //  added this
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/deltax_logo.png"),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
                    width: ScreenSize(context).width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Connexion", style: AppTextStyles.heading1()),
                        SizedBox(height: 5),
                        Text(
                          "Accédez à votre espace personnel",
                          style: AppTextStyles.body1(color: AppColors.darkGrey),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EmailTextForm(controller: emailCtrl),
                              SizedBox(height: 25),
                              PasswordTextForm(
                                label: "Mot de passe",
                                controller: passwordCtrl,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Mot de passe oublié ?",
                            style: AppTextStyles.body1(color: AppColors.orange),
                          ),
                        ),
                        SizedBox(height: 10),
                        MyButton(
                          child: "Se connecter",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).setUser(
                                email: emailCtrl.text.trim(),
                                username: emailCtrl.text.split('@').first,
                                photoUrl:
                                    "https://api.dicebear.com/9.x/avataaars/png?seed=${emailCtrl.text}",
                              );
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
                              "Vous n'avez pas de compte?",
                              style: AppTextStyles.body1(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/inscription');
                              },
                              child: Text(
                                "S'inscrire",
                                style: AppTextStyles.body1(
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ScreenSize(context).width * 0.3,
                              height: 1,
                              color: AppColors.lightLightGrey,
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
                              color: AppColors.lightLightGrey,
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        GoogleButton(
                          child: "Continuer avec Google",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
