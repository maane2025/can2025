import 'package:flutter/material.dart';
import 'base_page.dart';

class MoroccanCulturePage extends StatelessWidget {
  const MoroccanCulturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Culture Marocaine',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Illustration homme en djellaba
            Container(
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB8860B), Color(0xFFD2691E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2017/01/06/19/15/arab-1951533_1280.png',
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      'المغرب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Text(
                      'Maroc Authentique',
                      style: TextStyle(
                        color: Color(0xFFF5DEB3),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Grid des sections culturelles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                children: [
                  _CultureCard(
                    title: 'Cuisine Marocaine',
                    subtitle: 'Tagine, Couscous, Pastilla...',
                    imageUrl: 'https://images.unsplash.com/photo-1630175860333-5131bda75071?auto=format&fit=crop&w=400&q=80',
                    color: Color(0xFFB8860B),
                  ),
                  _CultureCard(
                    title: 'Art Marocain',
                    subtitle: 'Zellige, calligraphie, motifs...',
                    imageUrl: 'https://images.unsplash.com/photo-1628079849305-4e36beb02644?auto=format&fit=crop&w=400&q=80',
                    color: Color(0xFF8B4513),
                  ),
                  _CultureCard(
                    title: 'Musique Marocaine',
                    subtitle: 'Gnawa, Chaabi, Oud...',
                    imageUrl: 'https://images.unsplash.com/photo-1498479338428-c04e4fc63b3f?auto=format&fit=crop&w=400&q=80',
                    color: Color(0xFFD2691E),
                  ),
                  _CultureCard(
                    title: 'Architecture',
                    subtitle: 'Mosquées, riads, palais...',
                    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                    color: Color(0xFFCD853F),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Costume traditionnel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: const Color(0xFFF5DEB3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2017/01/06/19/15/arab-1951533_1280.png',
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Djellaba Traditionnelle',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Vêtement traditionnel porté par les hommes marocains, symbole d’élégance et de tradition ancestrale.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6D4C1B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Traditions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Traditions Marocaines',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB8860B),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Mariages, henné, fêtes religieuses, thé à la menthe, Ramadan... Découvrez la richesse des traditions marocaines.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6D4C1B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CultureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color color;

  const _CultureCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6D4C1B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 