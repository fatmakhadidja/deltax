import 'package:deltax/ui/screens/connexion.dart';
import 'package:deltax/ui/screens/inscription.dart';
import 'package:deltax/ui/screens/profil.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String connexion = '/connexion';
  static const String inscription = '/inscription';
  static const String profil = '/profil';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case connexion:
        return MaterialPageRoute(builder: (_) => const Connexion());
      case inscription:
        return MaterialPageRoute(builder: (_) => const Inscription());
      case profil:
        return MaterialPageRoute(builder: (_) => const Profil());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
