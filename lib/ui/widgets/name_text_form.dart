import 'package:flutter/material.dart';
import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';

class NameTextForm extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const NameTextForm({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
  });

  @override
  State<NameTextForm> createState() => _NameTextFormState();
}

class _NameTextFormState extends State<NameTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
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
                style: AppTextStyles.body1(
                  color: AppColors.pink,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        hint: Text(
          widget.hint,
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
          return "${widget.label} ne peut pas être vide";
        }
        return null;
      },
    );
  }
}
