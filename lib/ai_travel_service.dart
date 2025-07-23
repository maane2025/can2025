import 'travel_assistant_model.dart';

class AITravelService {
  // Base de données des hébergements par ville et budget
  static final Map<String, List<AccommodationRecommendation>> _accommodations = {
    'Marrakech': [
      AccommodationRecommendation(
        name: 'Riad Al Moussika',
        type: 'riad',
        location: 'Médina de Marrakech',
        pricePerNight: 120.0,
        rating: 4.8,
        description: 'Magnifique riad traditionnel au cœur de la médina, avec piscine intérieure et terrasse panoramique',
        amenities: ['WiFi', 'Piscine', 'Restaurant', 'Terrasse', 'Climatisation'],
        image: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=800',
        bookingUrl: 'https://booking.com',
      ),
      AccommodationRecommendation(
        name: 'Hôtel Atlas',
        type: 'hotel',
        location: 'Nouvelle Ville',
        pricePerNight: 80.0,
        rating: 4.2,
        description: 'Hôtel moderne avec vue sur l\'Atlas, idéal pour les familles',
        amenities: ['WiFi', 'Gym', 'Restaurant', 'Parking', 'Piscine'],
        image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800',
        bookingUrl: 'https://booking.com',
      ),
      AccommodationRecommendation(
        name: 'Palais Royal',
        type: 'hotel',
        location: 'Palmeraie',
        pricePerNight: 250.0,
        rating: 4.9,
        description: 'Luxueux hôtel 5 étoiles avec spa et golf',
        amenities: ['WiFi', 'Spa', 'Golf', 'Restaurant gastronomique', 'Piscine', 'Conciergerie'],
        image: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800',
        bookingUrl: 'https://booking.com',
      ),
    ],
    'Fès': [
      AccommodationRecommendation(
        name: 'Riad Fès',
        type: 'riad',
        location: 'Médina de Fès',
        pricePerNight: 100.0,
        rating: 4.7,
        description: 'Riad authentique dans la médina historique',
        amenities: ['WiFi', 'Terrasse', 'Restaurant', 'Climatisation'],
        image: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800',
        bookingUrl: 'https://booking.com',
      ),
    ],
    'Casablanca': [
      AccommodationRecommendation(
        name: 'Hôtel Casablanca',
        type: 'hotel',
        location: 'Centre-ville',
        pricePerNight: 90.0,
        rating: 4.3,
        description: 'Hôtel moderne au cœur de la ville économique',
        amenities: ['WiFi', 'Restaurant', 'Bar', 'Salle de conférence'],
        image: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800',
        bookingUrl: 'https://booking.com',
      ),
    ],
  };

  // Base de données des restaurants par ville et type de cuisine
  static final Map<String, List<RestaurantRecommendation>> _restaurants = {
    'Marrakech': [
      RestaurantRecommendation(
        name: 'Restaurant Dar Zellij',
        cuisine: 'marocaine',
        location: 'Médina',
        priceRange: 3.0,
        rating: 4.6,
        description: 'Cuisine traditionnelle marocaine authentique dans un cadre historique',
        specialties: ['Couscous Royal', 'Tajine de poulet', 'Pastilla', 'Thé à la menthe'],
        image: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800',
        phone: '+212 5 24 38 38 38',
      ),
      RestaurantRecommendation(
        name: 'Le Jardin',
        cuisine: 'internationale',
        location: 'Nouvelle Ville',
        priceRange: 4.0,
        rating: 4.4,
        description: 'Restaurant moderne avec cuisine fusion et jardin',
        specialties: ['Fruits de mer', 'Viandes grillées', 'Desserts', 'Cocktails'],
        image: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800',
        phone: '+212 5 24 39 39 39',
      ),
    ],
    'Fès': [
      RestaurantRecommendation(
        name: 'Café Clock',
        cuisine: 'marocaine',
        location: 'Médina',
        priceRange: 2.0,
        rating: 4.5,
        description: 'Café culturel avec cuisine traditionnelle et musique live',
        specialties: ['Tajine', 'Harira', 'Couscous', 'Musique gnawa'],
        image: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=800',
        phone: '+212 5 35 63 78 55',
      ),
    ],
  };

  // Base de données des activités par ville et intérêts
  static final Map<String, List<ActivityRecommendation>> _activities = {
    'Marrakech': [
      ActivityRecommendation(
        name: 'Visite guidée de la Médina',
        category: 'culturel',
        location: 'Médina de Marrakech',
        price: 25.0,
        rating: 4.7,
        description: 'Découvrez l\'histoire et la culture de la ville rouge avec un guide local',
        highlights: ['Souks traditionnels', 'Place Jemaa el-Fna', 'Architecture historique', 'Guide local'],
        image: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800',
        duration: '3 heures',
        isFamilyFriendly: true,
      ),
      ActivityRecommendation(
        name: 'Cours de cuisine marocaine',
        category: 'culturel',
        location: 'Riad en médina',
        price: 45.0,
        rating: 4.9,
        description: 'Apprenez à préparer les plats traditionnels marocains',
        highlights: ['Cours pratique', 'Marché local', 'Dégustation', 'Recettes à emporter'],
        image: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=800',
        duration: '4 heures',
        isFamilyFriendly: true,
      ),
      ActivityRecommendation(
        name: 'Balade en chameau dans le désert',
        category: 'aventure',
        location: 'Palmeraie',
        price: 35.0,
        rating: 4.6,
        description: 'Excursion dans la palmeraie avec coucher de soleil',
        highlights: ['Balade en chameau', 'Coucher de soleil', 'Thé berbère', 'Photos'],
        image: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800',
        duration: '2 heures',
        isFamilyFriendly: true,
      ),
    ],
    'Fès': [
      ActivityRecommendation(
        name: 'Visite des tanneries',
        category: 'culturel',
        location: 'Médina de Fès',
        price: 15.0,
        rating: 4.4,
        description: 'Découvrez l\'artisanat traditionnel du cuir',
        highlights: ['Tanneries historiques', 'Processus de tannage', 'Guide local'],
        image: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800',
        duration: '2 heures',
        isFamilyFriendly: false,
      ),
    ],
  };

  // Algorithme IA pour générer des recommandations personnalisées
  static TravelPlan generateTravelPlan(TravelPreferences preferences) {
    // Analyse du budget
    final budgetLevel = _analyzeBudget(preferences.budget);
    
    // Analyse des intérêts
    final interestCategories = _analyzeInterests(preferences.interests);
    
    // Génération des recommandations basées sur l'IA
    final accommodations = _generateAccommodationRecommendations(
      preferences.location,
      budgetLevel,
      preferences.accommodationType,
      preferences.numberOfTravelers,
    );
    
    final restaurants = _generateRestaurantRecommendations(
      preferences.location,
      budgetLevel,
      interestCategories,
      preferences.numberOfTravelers,
    );
    
    final activities = _generateActivityRecommendations(
      preferences.location,
      budgetLevel,
      interestCategories,
      preferences.numberOfTravelers,
    );
    
    // Calcul du coût total
    final totalCost = _calculateTotalCost(
      accommodations,
      restaurants,
      activities,
      preferences,
    );
    
    // Génération du résumé personnalisé
    final summary = _generatePersonalizedSummary(
      preferences,
      budgetLevel,
      interestCategories,
    );
    
    return TravelPlan(
      preferences: preferences,
      accommodations: accommodations,
      restaurants: restaurants,
      activities: activities,
      totalEstimatedCost: totalCost,
      summary: summary,
    );
  }

  // Analyse du budget avec IA
  static String _analyzeBudget(String budget) {
    final budgetLower = budget.toLowerCase();
    if (budgetLower.contains('luxe') || budgetLower.contains('premium') || 
        budgetLower.contains('1000') || budgetLower.contains('1500') || budgetLower.contains('2000')) {
      return 'luxury';
    } else if (budgetLower.contains('moyen') || budgetLower.contains('500') || 
               budgetLower.contains('800') || budgetLower.contains('1000')) {
      return 'medium';
    } else {
      return 'budget';
    }
  }

  // Analyse des intérêts avec IA
  static List<String> _analyzeInterests(List<String> interests) {
    final categories = <String>[];
    
    for (final interest in interests) {
      final interestLower = interest.toLowerCase();
      if (interestLower.contains('cuisine') || interestLower.contains('gastronomie')) {
        categories.add('food');
      }
      if (interestLower.contains('historique') || interestLower.contains('culture')) {
        categories.add('culture');
      }
      if (interestLower.contains('famille') || interestLower.contains('enfant')) {
        categories.add('family');
      }
      if (interestLower.contains('aventure') || interestLower.contains('sport')) {
        categories.add('adventure');
      }
      if (interestLower.contains('relaxation') || interestLower.contains('plage')) {
        categories.add('relaxation');
      }
      if (interestLower.contains('shopping') || interestLower.contains('souk')) {
        categories.add('shopping');
      }
    }
    
    return categories.isEmpty ? ['culture'] : categories;
  }

  // Génération intelligente d'hébergements
  static List<AccommodationRecommendation> _generateAccommodationRecommendations(
    String location,
    String budgetLevel,
    String accommodationType,
    int numberOfTravelers,
  ) {
    final availableAccommodations = _accommodations[location] ?? [];
    final recommendations = <AccommodationRecommendation>[];
    
    // Filtrage par type d'hébergement
    var filteredAccommodations = availableAccommodations.where((acc) {
      if (accommodationType == 'riad') return acc.type == 'riad';
      if (accommodationType == 'hotel') return acc.type == 'hotel';
      if (accommodationType == 'apartment') return acc.type == 'apartment';
      return true;
    }).toList();
    
    // Filtrage par budget
    filteredAccommodations = filteredAccommodations.where((acc) {
      switch (budgetLevel) {
        case 'luxury':
          return acc.pricePerNight >= 150;
        case 'medium':
          return acc.pricePerNight >= 60 && acc.pricePerNight < 150;
        case 'budget':
          return acc.pricePerNight < 60;
        default:
          return true;
      }
    }).toList();
    
    // Tri par note et sélection des meilleurs
    filteredAccommodations.sort((a, b) => b.rating.compareTo(a.rating));
    
    // Sélection intelligente basée sur le nombre de voyageurs
    final maxRecommendations = numberOfTravelers > 2 ? 3 : 2;
    recommendations.addAll(
      filteredAccommodations.take(maxRecommendations),
    );
    
    return recommendations;
  }

  // Génération intelligente de restaurants
  static List<RestaurantRecommendation> _generateRestaurantRecommendations(
    String location,
    String budgetLevel,
    List<String> interestCategories,
    int numberOfTravelers,
  ) {
    final availableRestaurants = _restaurants[location] ?? [];
    final recommendations = <RestaurantRecommendation>[];
    
    // Filtrage par budget
    var filteredRestaurants = availableRestaurants.where((rest) {
      switch (budgetLevel) {
        case 'luxury':
          return rest.priceRange >= 4;
        case 'medium':
          return rest.priceRange >= 2 && rest.priceRange < 4;
        case 'budget':
          return rest.priceRange < 2;
        default:
          return true;
      }
    }).toList();
    
    // Filtrage par intérêts culinaires
    if (interestCategories.contains('food')) {
      filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    }
    
    // Sélection variée
    final cuisineTypes = <String>{};
    for (final restaurant in filteredRestaurants) {
      if (cuisineTypes.length < 3 && !cuisineTypes.contains(restaurant.cuisine)) {
        cuisineTypes.add(restaurant.cuisine);
        recommendations.add(restaurant);
      }
    }
    
    return recommendations;
  }

  // Génération intelligente d'activités
  static List<ActivityRecommendation> _generateActivityRecommendations(
    String location,
    String budgetLevel,
    List<String> interestCategories,
    int numberOfTravelers,
  ) {
    final availableActivities = _activities[location] ?? [];
    final recommendations = <ActivityRecommendation>[];
    
    // Filtrage par intérêts
    var filteredActivities = availableActivities.where((act) {
      if (interestCategories.contains('culture') && act.category == 'culturel') return true;
      if (interestCategories.contains('adventure') && act.category == 'aventure') return true;
      if (interestCategories.contains('family') && act.isFamilyFriendly) return true;
      if (interestCategories.contains('relaxation') && act.category == 'relaxation') return true;
      return interestCategories.isEmpty;
    }).toList();
    
    // Filtrage par budget
    filteredActivities = filteredActivities.where((act) {
      switch (budgetLevel) {
        case 'luxury':
          return act.price >= 30;
        case 'medium':
          return act.price >= 15 && act.price < 30;
        case 'budget':
          return act.price < 15;
        default:
          return true;
      }
    }).toList();
    
    // Tri par note et sélection
    filteredActivities.sort((a, b) => b.rating.compareTo(a.rating));
    
    // Sélection intelligente
    final maxActivities = numberOfTravelers > 2 ? 4 : 3;
    recommendations.addAll(
      filteredActivities.take(maxActivities),
    );
    
    return recommendations;
  }

  // Calcul intelligent du coût total
  static double _calculateTotalCost(
    List<AccommodationRecommendation> accommodations,
    List<RestaurantRecommendation> restaurants,
    List<ActivityRecommendation> activities,
    TravelPreferences preferences,
  ) {
    // Estimation de la durée du séjour
    final startDate = DateTime.tryParse(preferences.startDate) ?? DateTime.now();
    final endDate = DateTime.tryParse(preferences.endDate) ?? DateTime.now();
    final duration = endDate.difference(startDate).inDays;
    
    // Coût hébergement
    final accommodationCost = accommodations.isNotEmpty 
        ? accommodations.first.pricePerNight * duration * preferences.numberOfTravelers
        : 0;
    
    // Coût restaurants (2 repas par jour)
    final restaurantCost = restaurants.isNotEmpty 
        ? restaurants.first.priceRange * 20 * duration * preferences.numberOfTravelers
        : 0;
    
    // Coût activités
    final activityCost = activities.fold(0.0, (sum, activity) => sum + activity.price) * preferences.numberOfTravelers;
    
    // Coût transport local
    final transportCost = duration * 15 * preferences.numberOfTravelers;
    
    return accommodationCost + restaurantCost + activityCost + transportCost;
  }

  // Génération du résumé personnalisé avec IA
  static String _generatePersonalizedSummary(
    TravelPreferences preferences,
    String budgetLevel,
    List<String> interestCategories,
  ) {
    final budgetText = budgetLevel == 'luxury' ? 'luxueux' : 
                      budgetLevel == 'medium' ? 'confortable' : 'économique';
    
    final interestText = interestCategories.contains('food') ? 'gastronomique' :
                        interestCategories.contains('culture') ? 'culturel' :
                        interestCategories.contains('family') ? 'familial' :
                        interestCategories.contains('adventure') ? 'aventureux' : 'diversifié';
    
    return 'Plan de voyage $budgetText et $interestText personnalisé pour ${preferences.numberOfTravelers} voyageur(s) à ${preferences.location}. '
           'Ce séjour combine hébergement de qualité, restaurants authentiques et activités adaptées à vos centres d\'intérêt. '
           'Profitez d\'une expérience marocaine authentique tout en assistant aux matchs de la CAN 2025 !';
  }
} 