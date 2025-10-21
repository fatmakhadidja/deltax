import 'package:deltax/core/const/colors.dart';
import 'package:deltax/core/const/text_styles.dart';
import 'package:deltax/core/providers/user_provider.dart';
import 'package:deltax/routes/routes.dart';
import 'package:deltax/ui/screens/accueil_page.dart';
import 'package:deltax/ui/screens/evenements.dart';
import 'package:deltax/ui/screens/notifications.dart';
import 'package:deltax/ui/widgets/button.dart';
import 'package:deltax/ui/widgets/connexionNavigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  static int _selectedInd = 0;

  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void _onItemTapped(int index, String? username) {
    if (index == 3) {
      if (username == null) {
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
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.darkGrey,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Consumer<UserProvider>(
                    builder: (context, user, _) {
                      if (user.isLoggedIn) {
                        return Center(
                          child: MyButton(
                            child: "Déconnexion",
                            onPressed: () {
                              user.logout();
                              Navigator.pop(context);
                              setState(() => Accueil._selectedInd = 0);
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: MyButton(
                            child: "Connexion / Inscription",
                            onPressed: () {
                              setState(() => Accueil._selectedInd = 2);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Navigation",
                    style: AppTextStyles.body1(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _menuItem(Icons.badge, "Annuaire", AppRoutes.annuaire),
                  _menuItem(
                    Icons.info,
                    "A propos de DeltaX",
                    AppRoutes.apropos,
                  ),
                  _menuItem(Icons.email, "Contactez nous", AppRoutes.contact),
                ],
              ),
            );
          },
        );
      } else {
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
                  // Header with profile
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.pink,
                        radius: 22,
                        child: Text(
                          username![0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? "Utilisateur",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            username ?? "",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.darkGrey,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Menu items
                  _menuItem(
                    Icons.person_outline,
                    "Mon Profil",
                    AppRoutes.profil,
                  ),
                  _menuItem(
                    Icons.receipt_long,
                    "Mes Réservations",
                    AppRoutes.reservations,
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "NAVIGATION",
                    style: AppTextStyles.body1(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _menuItem(Icons.badge, "Annuaire", AppRoutes.annuaire),
                  _menuItem(
                    Icons.info_outline,
                    "À propos de DELTA X",
                    AppRoutes.apropos,
                  ),
                  _menuItem(
                    Icons.mail_outline,
                    "Contactez-nous",
                    AppRoutes.contact,
                  ),

                  const SizedBox(height: 20),
                  const Divider(thickness: 0.5, color: Colors.grey),

                  // Logout button
                  Center(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.logout, color: AppColors.pink),
                      label: const Text(
                        "Se déconnecter",
                        style: TextStyle(color: AppColors.pink),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.pink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      }
    } else {
      setState(() => Accueil._selectedInd = index);
    }
  }

  Widget _menuItem(IconData icon, String title, String route) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkGrey),
          const SizedBox(width: 5),
          Text(
            title,
            style: AppTextStyles.body1(
              color: AppColors.darkGrey,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    final List<Widget> pages = (user.email != null)
        ? const [
            AccueilPage(),
            Evenements(),
            Notifications(),
          ] // Replace Placeholder with NotifsPage()
        : const [AccueilPage(), Evenements(), ConnexionNavigator()];

    final List<BottomNavigationBarItem> items = (user.email != null)
        ? const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Événements",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notifs",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ]
        : const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Événements",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: "Connexion",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ];

    return Scaffold(
      body: pages[Accueil._selectedInd],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Accueil._selectedInd,
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.darkGrey,
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(index, user.username),
        items: items,
      ),
    );
  }
}
