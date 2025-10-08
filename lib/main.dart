import 'package:deltax/ui/screens/connexion.dart';
import 'package:deltax/ui/screens/inscription.dart';
import 'package:deltax/routes/routes.dart'; // <-- your routes file
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.profil, // start screen
      onGenerateRoute: AppRoutes.generateRoute, // use the route generator
    );
  }
}
