import 'package:deltax/ui/widgets/reservationCard.dart';
import 'package:flutter/material.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<Reservation> reservations = [
    Reservation(
      title: "Parapente Cap Djennat",
      status: "Confirmée",
      date: DateTime(2025, 9, 30, 9, 0, 0),
      location: "35 - Boumerdès",
      places: 2,
    ),
    Reservation(
      title: "Randonnée Gouraya",
      status: "En attente",
      date: DateTime(2025, 10, 15, 8, 30, 0),
      location: "06 - Béjaïa",
      places: 1,
    ),
    Reservation(
      title: "Kayak Tigzirt",
      status: "Annulée",
      date: DateTime(2025, 8, 22, 10, 0, 0),
      location: "15 - Tizi Ouzou",
      places: 3,
    ),
  ];

  String selectedStatus = "Tous les statuts";
  String selectedDate = "Toutes les dates";
  String searchQuery = "";

  final List<String> statuses = [
    "Tous les statuts",
    "En attente",
    "Payment envoyé",
    "Confirmée",
    "Annulée",
    "Terminée",
  ];

  final List<String> dateFilters = ["Toutes les dates", "À venir", "Passées"];

  List<Reservation> get filteredReservations {
    final now = DateTime.now();

    return reservations.where((r) {
      final matchesSearch =
          r.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          r.location.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus =
          (selectedStatus == "Tous les statuts") || r.status == selectedStatus;

      bool matchesDate = true;
      if (selectedDate == "À venir") {
        matchesDate = r.date.isAfter(now);
      } else if (selectedDate == "Passées") {
        matchesDate = r.date.isBefore(now);
      }

      return matchesSearch && matchesStatus && matchesDate;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visibleReservations = filteredReservations;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mes Réservations",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

             
              TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher par événement, organisateur...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) {
                  setState(() => searchQuery = val);
                },
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statuses
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => selectedStatus = val!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: selectedDate,
                items: dateFilters
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => selectedDate = val!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

             
              Expanded(
                child: visibleReservations.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucune réservation trouvée.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: visibleReservations.length,
                        itemBuilder: (context, index) {
                          final r = visibleReservations[index];
                          return ReservationCard(
                            reservation: r,
                            onDetailsPressed: () {},
                            onPaymentProofPressed: () {},
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
