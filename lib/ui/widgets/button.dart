import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
  width: MediaQuery.of(context).size.width*0.7, 
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent, // show gradient
      shadowColor: Colors.transparent, // remove white/shadow overlay
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Ink(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF416C), Color(0xFFFF4B2C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          child,
          style: AppTextStyles.heading2(color: Colors.white),
        ),
      ),
    ),
  ),
);

  }
}
