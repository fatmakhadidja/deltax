import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';

class ConfirmPasswordTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextEditingController firstPassword;
  const ConfirmPasswordTextForm({
    super.key,
    required this.label,
    required this.controller,
    required this.firstPassword,
  });

  @override
  State<ConfirmPasswordTextForm> createState() =>
      _ConfirmPasswordTextFormState();
}

class _ConfirmPasswordTextFormState extends State<ConfirmPasswordTextForm> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !visible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              visible = !visible;
            });
          },
          icon: Icon(
            Icons.visibility,
            color: visible ? AppColors.orange : AppColors.darkGrey,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: AppTextStyles.body1(
                  color: AppColors.darkGrey,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: " *",
                style: AppTextStyles.body1(color: AppColors.pink, fontSize: 18),
              ),
            ],
          ),
        ),
        hint: Text(
          "Entrez votre mot de passe",
          style: AppTextStyles.body1(color: AppColors.lightGrey, fontSize: 14),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange, width: 1.7),
        ),
        focusColor: AppColors.orange,
      ),

      validator: (value) {
        if (value!.isEmpty) {
          return "Le mot de passe ne peut pas être vide";
        }
        if (value != widget.firstPassword.text.trim()) {
          return "Veuillez vous assurer que les deux mots de passe sont identiques";
        }
        if (value.length < 6) {
          return "Le mot de passe doit contenir au moins 6 caractères";
        }
        return null;
      },
    );
  }
}
