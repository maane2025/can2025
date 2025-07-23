import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'base_page.dart';

class VillestadeWidget extends StatefulWidget {
  const VillestadeWidget({Key? key}) : super(key: key);

  @override
  State<VillestadeWidget> createState() => _VillestadeWidgetState();
}

class _VillestadeWidgetState extends State<VillestadeWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final FlutterTts _tts = FlutterTts();
  final translator = GoogleTranslator();

  String _search = '';
  String _selectedLang = 'fr';

  final List<Map<String, dynamic>> stades = [
    {
      'nom': 'Stade Mohammed V',
      'ville': 'Casablanca',
      'capacite': '67,000',
      'histoire': 'Inauguré en 1955, ce stade emblématique accueille les plus grands matchs du football marocain.',
      'image': 'https://images.unsplash.com/photo-1726404165637-5eeee9a50109?auto=format&fit=crop&w=800&q=80',
      'lat': 33.5883,
      'lng': -7.6304,
    },
    {
      'nom': 'Complexe Sportif Prince Moulay Abdellah',
      'ville': 'Rabat',
      'capacite': '52,000',
      'histoire': 'Stade moderne inauguré en 1983, situé dans la capitale du Royaume.',
      'image': 'https://images.unsplash.com/photo-1637509069358-32ab21303d74?auto=format&fit=crop&w=800&q=80',
      'lat': 34.0006,
      'lng': -6.8443,
    },
    {
      'nom': 'Stade de Marrakech',
      'ville': 'Marrakech',
      'capacite': '45,240',
      'histoire': 'Stade ultramoderne inauguré en 2024, au cœur de la ville ocre.',
      'image': 'https://images.unsplash.com/photo-1556152353-9d5a70d3bd81?auto=format&fit=crop&w=800&q=80',
      'lat': 31.5456,
      'lng': -8.0606,
    },
    {
      'nom': 'Stade Ibn Batouta',
      'ville': 'Tanger',
      'capacite': '65,000',
      'histoire': 'Stade moderne inauguré en 2011, porte d’entrée du Maroc vers l’Europe.',
      'image': 'https://images.unsplash.com/photo-1623352209253-d3e999113b0f?auto=format&fit=crop&w=800&q=80',
      'lat': 35.7631,
      'lng': -5.8346,
    },
    {
      'nom': 'Complexe Sportif de Fès',
      'ville': 'Fès',
      'capacite': '35,000',
      'histoire': 'Stade rénové pour la CAN 2025, dans la capitale spirituelle du Maroc.',
      'image': 'https://images.unsplash.com/photo-1585406558210-13242837e6ef?auto=format&fit=crop&w=800&q=80',
      'lat': 34.0433,
      'lng': -4.9998,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _tts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    String langCode = _selectedLang;
    String ttsLang;
    switch (langCode) {
      case 'ar':
        ttsLang = 'ar-SA';
        break;
      case 'en':
        ttsLang = 'en-US';
        break;
      case 'es':
        ttsLang = 'es-ES';
        break;
      default:
        ttsLang = 'fr-FR';
    }
    await _tts.setLanguage(ttsLang);
    String toSay = text;
    if (langCode != 'fr') {
      final translation = await translator.translate(text, to: langCode);
      toSay = translation.text;
    }
    await _tts.speak(toSay);
  }

  void _showMap(BuildContext context, String nom, double lat, double lng) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Localisation de $nom'),
        content: SizedBox(
          width: 350,
          height: 300,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(lat, lng),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat, lng),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStades = stades.where((stade) {
      final query = _search.toLowerCase();
      return stade['nom']!.toLowerCase().contains(query) ||
          stade['ville']!.toLowerCase().contains(query);
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BasePage(
        title: 'Stades CAN 2025',
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(1, -1),
                      end: AlignmentDirectional(-1, 1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CAN Maroc 2025',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Découvrez les stades de compétition',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.stadium, color: Colors.white, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Guide Touristique',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Rechercher un stade ou une ville...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredStades.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final stade = filteredStades[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              stade['image']!,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stade['nom']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.red),
                                    const SizedBox(width: 4),
                                    Text(
                                      stade['ville']!,
                                      style: GoogleFonts.inter(fontSize: 16),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.people, size: 16, color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Capacité: ${stade['capacite']} places',
                                      style: GoogleFonts.inter(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  stade['histoire']!,
                                  style: GoogleFonts.inter(fontSize: 15, color: Colors.black87),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(stade['nom']!),
                                            content: Text(stade['histoire']!),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Fermer'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.info_outline),
                                      label: const Text('Histoire'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Theme.of(context).primaryColor,
                                        elevation: 0,
                                        side: BorderSide(color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _showMap(context, stade['nom']!, stade['lat'], stade['lng']);
                                      },
                                      icon: const Icon(Icons.map),
                                      label: const Text('Localisation'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor: Theme.of(context).primaryColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                      icon: const Icon(Icons.volume_up, color: Colors.blue),
                                      onPressed: () {
                                        _speak('${stade['nom']} à ${stade['ville']}. ${stade['histoire']}');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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