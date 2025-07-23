import 'package:flutter/material.dart';
import 'can_history_model.dart';

class CANEditionDetailPage extends StatefulWidget {
  final Map<String, dynamic> edition;

  const CANEditionDetailPage({super.key, required this.edition});

  @override
  State<CANEditionDetailPage> createState() => _CANEditionDetailPageState();
}

class _CANEditionDetailPageState extends State<CANEditionDetailPage>
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
                              'CAN ${widget.edition['year']}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Hôte: ${widget.edition['host']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 30,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildEditionOverview(),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Matches Principaux'),
                            const SizedBox(height: 20),
                            _buildMatchesList(),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Statistiques'),
                            const SizedBox(height: 20),
                            _buildStatistics(),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Joueurs Clés'),
                            const SizedBox(height: 20),
                            _buildKeyPlayers(),
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
    );
  }

  Widget _buildEditionOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vainqueur: ${widget.edition['winner']}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 15),
          _buildOverviewItem('Pays hôte', widget.edition['host']),
          _buildOverviewItem('Vainqueur', widget.edition['winner']),
          _buildOverviewItem('Finaliste', 'Finaliste de l\'édition'),
          _buildOverviewItem('3ème place', 'Troisième place'),
          _buildOverviewItem('4ème place', 'Quatrième place'),
          _buildOverviewItem('Meilleur buteur', 'Nom du buteur (X buts)'),
          _buildOverviewItem('Meilleur joueur', 'Nom du joueur'),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildMatchesList() {
    final matches = [
      {
        'home': 'Équipe A',
        'away': 'Équipe B',
        'homeScore': 2,
        'awayScore': 1,
        'stage': 'Finale',
        'date': 'Date de la finale',
        'scorers': ['Joueur A (45\')', 'Joueur B (67\')', 'Joueur C (89\')'],
      },
      {
        'home': 'Équipe C',
        'away': 'Équipe D',
        'homeScore': 0,
        'awayScore': 0,
        'stage': 'Demi-finale',
        'date': 'Date de la demi-finale',
        'scorers': ['Aucun but'],
      },
      {
        'home': 'Équipe E',
        'away': 'Équipe F',
        'homeScore': 3,
        'awayScore': 2,
        'stage': 'Quart de finale',
        'date': 'Date du quart de finale',
        'scorers': ['Joueur D (12\')', 'Joueur E (34\')', 'Joueur F (56\')', 'Joueur G (78\')', 'Joueur H (90\')'],
      },
    ];

    return Column(
      children: matches.map((match) {
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
                      match['stage']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      match['date']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        match['home']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${match['homeScore']} - ${match['awayScore']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        match['away']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((match['scorers'] as List<dynamic>?)?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Buteurs:',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (match['scorers'] as List<dynamic>?)?.join(', ') ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.green.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          _buildStatRow('Équipes participantes', '24'),
          _buildStatRow('Matches joués', '52'),
          _buildStatRow('Buts marqués', '119'),
          _buildStatRow('Moyenne de buts/match', '2.29'),
          _buildStatRow('Cartons jaunes', '187'),
          _buildStatRow('Cartons rouges', '8'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPlayers() {
    final players = [
      {
        'name': 'Meilleur Buteur',
        'player': 'Nom du joueur',
        'stats': 'X buts',
        'icon': Icons.sports_soccer,
        'color': Colors.orange,
      },
      {
        'name': 'Meilleur Joueur',
        'player': 'Nom du joueur',
        'stats': 'MVP de la compétition',
        'icon': Icons.person,
        'color': Colors.green,
      },
      {
        'name': 'Meilleur Gardien',
        'player': 'Nom du gardien',
        'stats': 'X clean sheets',
        'icon': Icons.sports_handball,
        'color': Colors.blue,
      },
    ];

    return Column(
      children: players.map((player) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: (player['color'] as Color?)?.withOpacity(0.1) ?? Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (player['color'] as Color?)?.withOpacity(0.3) ?? Colors.blue.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: player['color'] as Color? ?? Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  player['icon'] as IconData? ?? Icons.person,
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
                      player['name']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      player['player']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      player['stats']?.toString() ?? '',
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
        );
      }).toList(),
    );
  }
} 