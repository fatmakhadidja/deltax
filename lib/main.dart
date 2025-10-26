import 'package:deltax/core/providers/navigationProvider.dart';
import 'package:deltax/core/providers/user_provider.dart';
import 'package:deltax/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- important
  await initializeDateFormatting('fr_FR', null); // initialize locale data

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()), 
      ],
      child: const MyApp(), // mark const
    ),
  );
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
      initialRoute: AppRoutes.accueil,
      onGenerateRoute: AppRoutes.generateRoute,
      locale: const Locale('fr', 'FR'), 
    );
  }
}
