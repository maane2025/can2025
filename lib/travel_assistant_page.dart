import 'package:flutter/material.dart';
import 'travel_assistant_model.dart';
import 'travel_plan_result_page.dart';
import 'ai_travel_service.dart';
import 'base_page.dart';

class TravelAssistantPage extends StatefulWidget {
  const TravelAssistantPage({super.key});

  @override
  State<TravelAssistantPage> createState() => _TravelAssistantPageState();
}

class _TravelAssistantPageState extends State<TravelAssistantPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _budgetController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _locationController = TextEditingController();
  final _interestsController = TextEditingController();
  final _travelersController = TextEditingController(text: '1');

  String _selectedAccommodationType = 'hotel';
  List<String> _selectedInterests = [];

  final List<String> _availableInterests = [
    'Cuisine traditionnelle marocaine',
    'Sites historiques',
    'Activités familiales',
    'Shopping et souks',
    'Aventures et randonnées',
    'Plages et relaxation',
    'Culture berbère',
    'Musique et arts',
    'Photographie',
    'Sport et activités',
  ];

  final List<String> _cities = [
    'Casablanca',
    'Marrakech',
    'Fès',
    'Rabat',
    'Tanger',
    'Agadir',
    'Chefchaouen',
    'Essaouira',
    'Meknès',
    'Ouarzazate',
  ];

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
    _budgetController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _locationController.dispose();
    _interestsController.dispose();
    _travelersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Assistant IA Voyage',
      child: Scaffold(
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
                            'Assistant IA Voyage',
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
                      'Planifiez votre séjour au Maroc pour la CAN 2025 avec notre IA personnalisée',
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Informations de Voyage'),
                                const SizedBox(height: 20),
                                _buildTravelForm(),
                                
                                const SizedBox(height: 30),
                                
                                _buildSectionTitle('Préférences'),
                                const SizedBox(height: 20),
                                _buildPreferencesSection(),
                                
                                const SizedBox(height: 40),
                                
                                _buildGenerateButton(),
                              ],
                            ),
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

  Widget _buildTravelForm() {
    return Column(
      children: [
        // Budget
        _buildTextField(
          controller: _budgetController,
          label: 'Budget (ex: 1500 USD, budget moyen)',
          icon: Icons.attach_money,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez indiquer votre budget';
            }
            return null;
          },
        ),
        
        const SizedBox(height: 16),
        
        // Dates
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _startDateController,
                label: 'Date d\'arrivée',
                icon: Icons.calendar_today,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date requise';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _endDateController,
                label: 'Date de départ',
                icon: Icons.calendar_today,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date requise';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Location
        _buildDropdownField(
          label: 'Ville de destination',
          value: _locationController.text.isEmpty ? null : _locationController.text,
          items: _cities,
          onChanged: (value) {
            setState(() {
              _locationController.text = value ?? '';
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez sélectionner une ville';
            }
            return null;
          },
        ),
        
        const SizedBox(height: 16),
        
        // Number of travelers
        _buildTextField(
          controller: _travelersController,
          label: 'Nombre de voyageurs',
          icon: Icons.people,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez indiquer le nombre de voyageurs';
            }
            final number = int.tryParse(value);
            if (number == null || number < 1) {
              return 'Nombre invalide';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accommodation type
        Text(
          'Type d\'hébergement',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildChoiceChip('Hôtel', 'hotel'),
            const SizedBox(width: 8),
            _buildChoiceChip('Riad', 'riad'),
            const SizedBox(width: 8),
            _buildChoiceChip('Appartement', 'apartment'),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Interests
        Text(
          'Centres d\'intérêt (sélectionnez plusieurs)',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableInterests.map((interest) {
            return _buildInterestChip(interest);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label, String value) {
    final isSelected = _selectedAccommodationType == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedAccommodationType = value;
        });
      },
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInterestChip(String interest) {
    final isSelected = _selectedInterests.contains(interest);
    return FilterChip(
      label: Text(interest),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedInterests.add(interest);
          } else {
            _selectedInterests.remove(interest);
          }
        });
      },
      selectedColor: Colors.green.withOpacity(0.3),
      checkmarkColor: Colors.green,
      labelStyle: TextStyle(
        color: isSelected ? Colors.green : Colors.grey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _generateTravelPlan,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Générer mon plan de voyage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generateTravelPlan() async {
    if (_formKey.currentState!.validate() && _selectedInterests.isNotEmpty) {
      // Afficher le dialogue de chargement IA
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildAILoadingDialog(),
      );

      final preferences = TravelPreferences(
        budget: _budgetController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        location: _locationController.text,
        interests: _selectedInterests,
        numberOfTravelers: int.parse(_travelersController.text),
        accommodationType: _selectedAccommodationType,
      );

      // Simuler le traitement IA
      await Future.delayed(const Duration(seconds: 3));

      // Fermer le dialogue de chargement
      Navigator.pop(context);

      // Utiliser l'IA pour générer le plan de voyage
      final travelPlan = AITravelService.generateTravelPlan(preferences);

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              TravelPlanResultPage(travelPlan: travelPlan),
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
    } else if (_selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins un centre d\'intérêt'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAILoadingDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animation IA
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 2000),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'IA en cours d\'analyse...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Génération de votre plan de voyage personnalisé',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
} 