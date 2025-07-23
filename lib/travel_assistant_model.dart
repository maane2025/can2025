class TravelPreferences {
  final String budget;
  final String startDate;
  final String endDate;
  final String location;
  final List<String> interests;
  final int numberOfTravelers;
  final String accommodationType;

  TravelPreferences({
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.interests,
    required this.numberOfTravelers,
    required this.accommodationType,
  });
}

class AccommodationRecommendation {
  final String name;
  final String type; // hotel, riad, apartment
  final String location;
  final double pricePerNight;
  final double rating;
  final String description;
  final List<String> amenities;
  final String image;
  final String bookingUrl;

  AccommodationRecommendation({
    required this.name,
    required this.type,
    required this.location,
    required this.pricePerNight,
    required this.rating,
    required this.description,
    required this.amenities,
    required this.image,
    required this.bookingUrl,
  });
}

class RestaurantRecommendation {
  final String name;
  final String cuisine; // moroccan, international, seafood, etc.
  final String location;
  final double priceRange; // 1-5 scale
  final double rating;
  final String description;
  final List<String> specialties;
  final String image;
  final String phone;

  RestaurantRecommendation({
    required this.name,
    required this.cuisine,
    required this.location,
    required this.priceRange,
    required this.rating,
    required this.description,
    required this.specialties,
    required this.image,
    required this.phone,
  });
}

class ActivityRecommendation {
  final String name;
  final String category; // cultural, adventure, relaxation, shopping
  final String location;
  final double price;
  final double rating;
  final String description;
  final List<String> highlights;
  final String image;
  final String duration;
  final bool isFamilyFriendly;

  ActivityRecommendation({
    required this.name,
    required this.category,
    required this.location,
    required this.price,
    required this.rating,
    required this.description,
    required this.highlights,
    required this.image,
    required this.duration,
    required this.isFamilyFriendly,
  });
}

class TravelPlan {
  final TravelPreferences preferences;
  final List<AccommodationRecommendation> accommodations;
  final List<RestaurantRecommendation> restaurants;
  final List<ActivityRecommendation> activities;
  final double totalEstimatedCost;
  final String summary;

  TravelPlan({
    required this.preferences,
    required this.accommodations,
    required this.restaurants,
    required this.activities,
    required this.totalEstimatedCost,
    required this.summary,
  });
} 