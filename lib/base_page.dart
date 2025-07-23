import 'package:flutter/material.dart';
import 'main.dart';
import 'quiz_selection_page.dart';
import 'tourist_sites_page.dart';
import 'moroccan_culture_page.dart';
import 'can_history_page.dart';
import 'travel_assistant_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showBackButton;

  const BasePage({
    Key? key,
    required this.child,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Red Header Bar
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (showBackButton)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    if (!showBackButton)
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => _showNavigationDrawer(context),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.sports_soccer,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Page Content
          Expanded(child: child),
        ],
      ),
    );
  }

  void _showNavigationDrawer(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sports_soccer,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'CAN 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              const Divider(color: Colors.white24, height: 1),
              
              // Navigation Items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      _buildNavItem(
                        context,
                        icon: Icons.sports_soccer,
                        title: 'Stades',
                        subtitle: 'Découvrir les arènes',
                        onTap: () {
                          // Désactivé car StadiumsHomePage n'existe pas
                          // Navigator.pop(context);
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const StadiumsHomePage(),
                          //   ),
                          // );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildNavItem(
                        context,
                        icon: Icons.quiz,
                        title: 'Quiz',
                        subtitle: 'Tester vos connaissances',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizSelectionPage(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildNavItem(
                        context,
                        icon: Icons.explore,
                        title: 'Sites Touristiques',
                        subtitle: 'Découvrir le Maroc',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TouristSitesPage(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildNavItem(
                        context,
                        icon: Icons.celebration,
                        title: 'Culture Marocaine',
                        subtitle: 'Découvrir les traditions',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoroccanCulturePage(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildNavItem(
                        context,
                        icon: Icons.history,
                        title: 'Histoire de la CAN',
                        subtitle: 'Découvrir l\'histoire',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CANHistoryPage(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildNavItem(
                        context,
                        icon: Icons.auto_awesome,
                        title: 'Assistant IA Voyage',
                        subtitle: 'Planifier votre séjour',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelAssistantPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'CAN MAROC 2025',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 