import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';

class EmailTextForm extends StatefulWidget {
  final TextEditingController controller;
  const EmailTextForm({super.key, required this.controller});

  @override
  State<EmailTextForm> createState() => _EmailTextFormState();
}

class _EmailTextFormState extends State<EmailTextForm> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  widget.controller.clear();
                  setState(() {});
                },
                icon: const Icon(Icons.clear_rounded, color: AppColors.darkGrey),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Email",
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
        hintText: "Entrez votre adresse e-mail",
        hintStyle: AppTextStyles.body1(
          color: AppColors.lightGrey,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange, width: 1.7),
        ),
      ),
      validator: (value) {
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$');

        if (value == null || value.isEmpty) {
          return "L'adresse e-mail ne peut pas être vide";
        }
        if (!emailRegex.hasMatch(value)) {
          return "Format d'adresse e-mail invalide";
        }
        return null;
      },
    );
  }
}
