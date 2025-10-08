import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';

class PasswordTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  const PasswordTextForm({super.key, required this.label, required this.controller});

  @override
  State<PasswordTextForm> createState() => _PasswordTextFormState();
}

class _PasswordTextFormState extends State<PasswordTextForm> {
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
                text: "Mot de passe",
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
        hintText: "Entrez votre mot de passe",
        hintStyle: AppTextStyles.body1(color: AppColors.lightGrey, fontSize: 14),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange, width: 1.7),
        ),
        focusColor: AppColors.orange,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Le mot de passe ne peut pas être vide";
        }
        if (value.length < 6) {
          return "Le mot de passe doit contenir au moins 6 caractères";
        }
        return null;
      },
    );
  }
}
