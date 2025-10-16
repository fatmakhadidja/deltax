import 'package:deltax/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);
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

      initialRoute: AppRoutes.evenements,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
