import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/routes/routes.dart';
import 'package:deltax/ui/screens/evenements.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:deltax/ui/widgets/connexionNavigator.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  static int _selectedInd = 0;

  static const List<Widget> _pages = [
    // AccueilPage(),
    Center(child: Text("accueil here")),
    Evenements(),
    ConnexionNavigator(),
  ];
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void _onItemTapped(int index) {
    if (index == 3) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Menu",
                      style: AppTextStyles.body1(
                        color: AppColors.darkGrey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.darkGrey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      child: "Connexion/inscription",
                      onPressed: () {
                        setState(() {
                          Accueil._selectedInd = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Navigation",
                  style: AppTextStyles.body1(
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.annuaire);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.badge, color: AppColors.darkGrey),
                        SizedBox(width: 5),
                        Text(
                          "Annuaire",
                          style: AppTextStyles.body1(
                            color: AppColors.darkGrey,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.apropos);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: AppColors.darkGrey),
                        SizedBox(width: 5),
                        Text(
                          "A propos de DeltaX",
                          style: AppTextStyles.body1(
                            color: AppColors.darkGrey,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.contact);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.email, color: AppColors.darkGrey),
                        SizedBox(width: 5),
                        Text(
                          "Contactez nous",
                          style: AppTextStyles.body1(
                            color: AppColors.darkGrey,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        Accueil._selectedInd = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Accueil._pages[Accueil._selectedInd],

      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: Accueil._selectedInd,
        onTap: (index) => _onItemTapped(index),
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.darkGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Evenements",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: "Connexion"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}
