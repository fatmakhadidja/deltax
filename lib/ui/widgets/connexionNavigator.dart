
import 'package:deltax/ui/screens/connexion.dart';
import 'package:deltax/ui/screens/inscription.dart';
import 'package:flutter/material.dart';

class ConnexionNavigator extends StatelessWidget {
  const ConnexionNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page = const Connexion();

        if (settings.name == '/inscription') {
          page = const Inscription(); 
        }

        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}
