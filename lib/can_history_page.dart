import 'package:flutter/material.dart';
import 'can_history_model.dart';
import 'can_edition_detail_page.dart';
import 'can_statistics_page.dart';
import 'tourist_sites_page.dart';
import 'quiz_selection_page.dart';
import 'restaurant_widget.dart';
import 'base_page.dart';

class CANHistoryPage extends StatefulWidget {
  const CANHistoryPage({super.key});

  @override
  State<CANHistoryPage> createState() => _CANHistoryPageState();
}

class _CANHistoryPageState extends State<CANHistoryPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Histoire de la CAN',
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Histoire de la CAN'),
          actions: [
            IconButton(
              icon: const Icon(Icons.public),
              tooltip: 'Culture',
              onPressed: () {
                // MoroccanCulturePage désactivée
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'CAN History',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CANHistoryPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.place),
              tooltip: 'Tourisme',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TouristSitesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.quiz),
              tooltip: 'Quiz',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizSelectionPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.restaurant),
              tooltip: 'Restaurants',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RestaurantWidget()),
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1E3A8A),
                Color(0xFF3B82F6),
                Color(0xFF60A5FA),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Histoire de la CAN',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Subtitle
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Découvrez l\'histoire complète de la Coupe d\'Afrique des Nations',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Content
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Éditions de la CAN'),
                              const SizedBox(height: 20),
                              _buildEditionsGrid(),
                              
                              const SizedBox(height: 40),
                              
                              _buildSectionTitle('Statistiques & Records'),
                              const SizedBox(height: 20),
                              _buildStatisticsGrid(),
                              
                              const SizedBox(height: 40),
                              
                              _buildSectionTitle('Moments Historiques'),
                              const SizedBox(height: 20),
                              _buildHistoricMoments(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildEditionsGrid() {
    final recentEditions = [
      {'year': 2023, 'host': 'Côte d\'Ivoire', 'winner': 'Côte d\'Ivoire', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
      {'year': 2021, 'host': 'Cameroun', 'winner': 'Sénégal', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
      {'year': 2019, 'host': 'Égypte', 'winner': 'Algérie', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
      {'year': 2017, 'host': 'Gabon', 'winner': 'Cameroun', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
      {'year': 2015, 'host': 'Guinée équatoriale', 'winner': 'Côte d\'Ivoire', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
      {'year': 2013, 'host': 'Afrique du Sud', 'winner': 'Nigeria', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: recentEditions.length,
      itemBuilder: (context, index) {
        final edition = recentEditions[index];
        return _buildEditionCard(edition);
      },
    );
  }

  Widget _buildEditionCard(Map<String, dynamic> edition) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CANEditionDetailPage(edition: edition),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(edition['image']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'CAN ${edition['year']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hôte: ${edition['host']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vainqueur: ${edition['winner']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Voir détails',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          'Meilleurs Buteurs',
          'Découvrez les 20 meilleurs buteurs de l\'histoire',
          Icons.sports_soccer,
          Colors.orange,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CANStatisticsPage(type: 'scorers'),
            ),
          ),
        ),
        _buildStatCard(
          'Meilleurs Joueurs',
          'Les joueurs décisifs de chaque édition',
          Icons.person,
          Colors.green,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CANStatisticsPage(type: 'players'),
            ),
          ),
        ),
        _buildStatCard(
          'Joueurs les Plus Capés',
          'Les joueurs ayant disputé le plus de matches',
          Icons.emoji_events,
          Colors.purple,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CANStatisticsPage(type: 'capped'),
            ),
          ),
        ),
        _buildStatCard(
          'Moments Historiques',
          'Les moments qui ont marqué l\'histoire',
          Icons.history,
          Colors.red,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CANStatisticsPage(type: 'moments'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoricMoments() {
    final moments = [
      {
        'title': 'Première édition (1957)',
        'description': 'La première CAN organisée au Soudan',
        'year': '1957',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      },
      {
        'title': 'L\'Égypte domine (2006-2010)',
        'description': '3 titres consécutifs pour l\'Égypte',
        'year': '2006-2010',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      },
      {
        'title': 'Le Maroc en finale (2004)',
        'description': 'Première finale pour le Maroc',
        'year': '2004',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      },
    ];

    return Column(
      children: moments.map((moment) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(moment['image'] ?? 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moment['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        moment['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          moment['year'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
} 