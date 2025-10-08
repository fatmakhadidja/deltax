import 'package:deltax/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/ui/widgets/password_text_form.dart';
import 'package:deltax/ui/widgets/confirm_password_text_form.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      // Ici tu peux appeler ton backend / Firebase / API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mot de passe modifié avec succès")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightLightGrey,
      appBar: AppBar(
        title: Text(
          "Changer le mot de passe",
          style: AppTextStyles.heading1(fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PasswordTextForm(
                        label: "Mot de passe actuel",
                        controller: currentPasswordCtrl,
                      ),
                      const SizedBox(height: 20),
                      PasswordTextForm(
                        label: "Nouveau mot de passe",
                        controller: newPasswordCtrl,
                      ),
                      const SizedBox(height: 20),
                      ConfirmPasswordTextForm(
                        label: "Confirmer le nouveau mot de passe",
                        controller: confirmPasswordCtrl,
                        firstPassword: newPasswordCtrl,
                      ),
                      const SizedBox(height: 30),
                      MyButton(onPressed: _savePassword, child: "Enregistrer"),
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
