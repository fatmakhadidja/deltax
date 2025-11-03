import 'package:deltax/core/providers/navigationProvider.dart';
import 'package:deltax/core/providers/user_provider.dart';
import 'package:deltax/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  final context = WidgetsBinding.instance.renderViewElement;
  final images = [
    'assets/images/ski.jpg',
    'assets/images/diving.jpg',
    'assets/images/randonnee.jpg',
    'assets/images/safari.jpg',
  ];

  if (context != null) {
    for (final path in images) {
      await precacheImage(AssetImage(path), context);
    }
  }

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.generateRoute,
        locale: const Locale('fr', 'FR'),
      ),
    );
  }
}
