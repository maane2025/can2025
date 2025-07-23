import 'package:flutter/material.dart';
import 'base_page.dart';
import 'moroccan_culture_page.dart';
import 'can_history_page.dart';
import 'quiz_selection_page.dart';
import 'restaurant_widget.dart';

class TouristSitesPage extends StatelessWidget {
  const TouristSitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Sites Touristiques',
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Sites Touristiques'),
          actions: [
            IconButton(
              icon: const Icon(Icons.public),
              tooltip: 'Culture',
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const MoroccanCulturePage()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'CAN History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CANHistoryPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.place),
              tooltip: 'Tourisme',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TouristSitesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.quiz),
              tooltip: 'Quiz',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizSelectionPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.restaurant),
              tooltip: 'Restaurants',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RestaurantWidget()),
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('Page Sites Touristiques'),
        ),
      ),
    );
  }
} 