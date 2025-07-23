import 'package:flutter/material.dart';

class TouristSite {
  final String id;
  final String name;
  final String description;
  final String address;
  final String location;
  final String city;
  final SiteType type;
  final String imageUrl;
  final double rating;
  final String openingHours;
  final String price;
  final List<String> tags;

  TouristSite({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.location,
    required this.city,
    required this.type,
    required this.imageUrl,
    this.rating = 4.5,
    this.openingHours = '9h-17h',
    this.price = 'Gratuit',
    this.tags = const [],
  });

  factory TouristSite.fromJson(Map<String, dynamic> json) {
    return TouristSite(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      location: json['location'],
      city: json['city'],
      type: SiteType.values.firstWhere((e) => e.toString() == 'SiteType.${json['type']}'),
      imageUrl: json['imageUrl'],
      rating: json['rating']?.toDouble() ?? 4.5,
      openingHours: json['openingHours'] ?? '9h-17h',
      price: json['price'] ?? 'Gratuit',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'location': location,
      'city': city,
      'type': type.toString().split('.').last,
      'imageUrl': imageUrl,
      'rating': rating,
      'openingHours': openingHours,
      'price': price,
      'tags': tags,
    };
  }
}

enum SiteType {
  mosque,
  palace,
  museum,
  garden,
  market,
  historical,
  beach,
  nature,
  cultural,
  entertainment,
}

extension SiteTypeExtension on SiteType {
  String get displayName {
    switch (this) {
      case SiteType.mosque:
        return 'Mosquée';
      case SiteType.palace:
        return 'Palais';
      case SiteType.museum:
        return 'Musée';
      case SiteType.garden:
        return 'Jardin';
      case SiteType.market:
        return 'Marché';
      case SiteType.historical:
        return 'Site Historique';
      case SiteType.beach:
        return 'Plage';
      case SiteType.nature:
        return 'Nature';
      case SiteType.cultural:
        return 'Culturel';
      case SiteType.entertainment:
        return 'Divertissement';
    }
  }

  IconData get icon {
    switch (this) {
      case SiteType.mosque:
        return Icons.mosque;
      case SiteType.palace:
        return Icons.castle;
      case SiteType.museum:
        return Icons.museum;
      case SiteType.garden:
        return Icons.park;
      case SiteType.market:
        return Icons.store;
      case SiteType.historical:
        return Icons.history_edu;
      case SiteType.beach:
        return Icons.beach_access;
      case SiteType.nature:
        return Icons.nature;
      case SiteType.cultural:
        return Icons.theater_comedy;
      case SiteType.entertainment:
        return Icons.celebration;
    }
  }

  Color get color {
    switch (this) {
      case SiteType.mosque:
        return Colors.green;
      case SiteType.palace:
        return Colors.amber;
      case SiteType.museum:
        return Colors.blue;
      case SiteType.garden:
        return Colors.lightGreen;
      case SiteType.market:
        return Colors.orange;
      case SiteType.historical:
        return Colors.brown;
      case SiteType.beach:
        return Colors.cyan;
      case SiteType.nature:
        return Colors.teal;
      case SiteType.cultural:
        return Colors.purple;
      case SiteType.entertainment:
        return Colors.pink;
    }
  }
} 