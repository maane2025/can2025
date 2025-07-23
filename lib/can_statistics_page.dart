import 'package:flutter/material.dart';
import 'can_history_model.dart';

class CANStatisticsPage extends StatefulWidget {
  final String type; // 'scorers', 'players', 'capped', 'moments'

  const CANStatisticsPage({super.key, required this.type});

  @override
  State<CANStatisticsPage> createState() => _CANStatisticsPageState();
}

class _CANStatisticsPageState extends State<CANStatisticsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
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
      begin: const Offset(0, 0.2),
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

  String get pageTitle {
    switch (widget.type) {
      case 'scorers':
        return 'Meilleurs Buteurs';
      case 'players':
        return 'Meilleurs Joueurs';
      case 'capped':
        return 'Joueurs les Plus Capés';
      case 'moments':
        return 'Moments Historiques';
      default:
        return 'Statistiques';
    }
  }

  String get pageSubtitle {
    switch (widget.type) {
      case 'scorers':
        return 'Les 20 meilleurs buteurs de l\'histoire de la CAN';
      case 'players':
        return 'Les joueurs décisifs de chaque édition';
      case 'capped':
        return 'Les joueurs ayant disputé le plus de matches';
      case 'moments':
        return 'Les moments qui ont marqué l\'histoire';
      default:
        return 'Statistiques de la CAN';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pageTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              pageSubtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
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
                        child: _buildContent(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.type) {
      case 'scorers':
        return _buildTopScorers();
      case 'players':
        return _buildBestPlayers();
      case 'capped':
        return _buildMostCappedPlayers();
      case 'moments':
        return _buildHistoricMoments();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTopScorers() {
    final topScorers = [
      {'name': 'Samuel Eto\'o', 'country': 'Cameroun', 'goals': 18, 'editions': '2000-2010'},
      {'name': 'Laurent Pokou', 'country': 'Côte d\'Ivoire', 'goals': 14, 'editions': '1968-1980'},
      {'name': 'Rashidi Yekini', 'country': 'Nigeria', 'goals': 13, 'editions': '1988-1994'},
      {'name': 'Hassan El-Shazly', 'country': 'Égypte', 'goals': 12, 'editions': '1963-1970'},
      {'name': 'Patrick M\'Boma', 'country': 'Cameroun', 'goals': 11, 'editions': '1996-2002'},
      {'name': 'Didier Drogba', 'country': 'Côte d\'Ivoire', 'goals': 11, 'editions': '2006-2012'},
      {'name': 'Kalusha Bwalya', 'country': 'Zambie', 'goals': 10, 'editions': '1986-1996'},
      {'name': 'Hossam Hassan', 'country': 'Égypte', 'goals': 9, 'editions': '1986-2006'},
      {'name': 'Ndaye Mulamba', 'country': 'RDC', 'goals': 9, 'editions': '1974'},
      {'name': 'Jay-Jay Okocha', 'country': 'Nigeria', 'goals': 8, 'editions': '1994-2004'},
    ];

    return Column(
      children: topScorers.asMap().entries.map((entry) {
        final index = entry.key;
        final scorer = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: index < 3 ? Colors.orange.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: index < 3 ? Colors.orange.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: index < 3 ? Colors.orange : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scorer['name']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    Text(
                      scorer['country']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Éditions: ${scorer['editions']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: index < 3 ? Colors.orange : Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${scorer['goals']} buts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBestPlayers() {
    final bestPlayers = [
      {
        'name': 'Samuel Eto\'o',
        'country': 'Cameroun',
        'position': 'Attaquant',
        'awards': ['Meilleur joueur 2006', 'Meilleur buteur 2008'],
        'description': 'Légende du football africain, 4 titres de CAN',
      },
      {
        'name': 'Didier Drogba',
        'country': 'Côte d\'Ivoire',
        'position': 'Attaquant',
        'awards': ['Meilleur joueur 2012'],
        'description': 'Capitaine emblématique des Éléphants',
      },
      {
        'name': 'Yaya Touré',
        'country': 'Côte d\'Ivoire',
        'position': 'Milieu',
        'awards': ['Meilleur joueur 2015'],
        'description': 'Milieu de terrain dominant, 4 participations',
      },
      {
        'name': 'Riyad Mahrez',
        'country': 'Algérie',
        'position': 'Attaquant',
        'awards': ['Meilleur joueur 2019'],
        'description': 'Leader technique de l\'équipe algérienne',
      },
    ];

    return Column(
      children: bestPlayers.map((player) {
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player['name']?.toString() ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          Text(
                            '${player['country']} - ${player['position']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  player['description']?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: (player['awards'] as List<String>).map((award) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        award,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMostCappedPlayers() {
    final mostCapped = [
      {
        'name': 'Rigobert Song',
        'country': 'Cameroun',
        'matches': 36,
        'editions': 8,
        'period': '1996-2010',
        'description': 'Capitaine emblématique des Lions Indomptables',
      },
      {
        'name': 'Ahmed Hassan',
        'country': 'Égypte',
        'matches': 33,
        'editions': 8,
        'period': '1996-2010',
        'description': 'Recordman de participations avec l\'Égypte',
      },
      {
        'name': 'Essam El-Hadary',
        'country': 'Égypte',
        'matches': 32,
        'editions': 8,
        'period': '1996-2017',
        'description': 'Gardien légendaire, 4 titres de CAN',
      },
      {
        'name': 'Yaya Touré',
        'country': 'Côte d\'Ivoire',
        'matches': 30,
        'editions': 6,
        'period': '2006-2015',
        'description': 'Milieu de terrain dominant',
      },
    ];

    return Column(
      children: mostCapped.map((player) {
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player['name']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      Text(
                        player['country']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${player['period']} (${player['editions']} éditions)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${player['matches']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const Text(
                      'matches',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoricMoments() {
    final moments = [
      {
        'title': 'Première édition (1957)',
        'description': 'La première CAN organisée au Soudan avec seulement 3 équipes',
        'year': '1957',
        'category': 'Historique',
      },
      {
        'title': 'L\'Égypte domine (2006-2010)',
        'description': '3 titres consécutifs pour l\'Égypte, une performance unique',
        'year': '2006-2010',
        'category': 'Performance',
      },
      {
        'title': 'Le Maroc en finale (2004)',
        'description': 'Première finale pour le Maroc, défaite face à la Tunisie',
        'year': '2004',
        'category': 'Première',
      },
      {
        'title': 'La Zambie triomphe (2012)',
        'description': 'Victoire émotionnelle après le crash aérien de 1993',
        'year': '2012',
        'category': 'Émotion',
      },
      {
        'title': 'L\'Algérie championne (2019)',
        'description': 'Premier titre depuis 1990, victoire face au Sénégal',
        'year': '2019',
        'category': 'Victoire',
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      moment['title']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        moment['category']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  moment['description']?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  moment['year']?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
} 