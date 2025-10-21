import 'package:deltax/ui/screens/accueil.dart';
import 'package:deltax/ui/screens/annuaire.dart';
import 'package:deltax/ui/screens/change_password.dart';
import 'package:deltax/ui/screens/connexion.dart';
import 'package:deltax/ui/screens/evenements.dart';
import 'package:deltax/ui/screens/inscription.dart';
import 'package:deltax/ui/screens/notifications.dart';
import 'package:deltax/ui/screens/profil.dart';
import 'package:deltax/ui/screens/reservations.dart';
import 'package:deltax/ui/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String connexion = '/connexion';
  static const String inscription = '/inscription';
  static const String profil = '/profil';
  static const String evenements = '/evenements';
  static const String changePassword = '/changePassword';
  static const String splash = '/splash';
  static const String accueil = '/accueil';
  static const String notifications = '/notifications';
  static const String reservations = '/reservations';
  static const String annuaire = '/annuaire';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case connexion:
        return MaterialPageRoute(builder: (_) => const Connexion());
      case inscription:
        return MaterialPageRoute(builder: (_) => const Inscription());
      case profil:
        return MaterialPageRoute(builder: (_) => const Profil());
      case changePassword :
        return MaterialPageRoute(builder: (_) => const ChangePassword()); 
      case evenements :
        return MaterialPageRoute(builder: (_) => const Evenements());  
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash());  
      case accueil:
        return MaterialPageRoute(builder: (_) =>  Accueil()); 
      case notifications:
         return MaterialPageRoute(builder: (_) =>  Notifications()); 
      case reservations:
         return MaterialPageRoute(builder: (_) =>  Reservations());   
      case annuaire :
         return MaterialPageRoute(builder: (_) =>  Annuaire());   
          
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
