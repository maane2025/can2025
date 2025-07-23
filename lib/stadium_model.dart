class Stadium {
  final String id;
  final String name;
  final String officialName;
  final String city;
  final String locationDetails;
  final int capacity;
  final String mainUse;
  final String shortDescription;
  final String image;
  final String dataAiHint;
  final List<String> milestones;
  final List<String> photosByEra;

  Stadium({
    required this.id,
    required this.name,
    required this.officialName,
    required this.city,
    required this.locationDetails,
    required this.capacity,
    required this.mainUse,
    required this.shortDescription,
    required this.image,
    required this.dataAiHint,
    required this.milestones,
    required this.photosByEra,
  });

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      officialName: json['officialName'] ?? '',
      city: json['city'] ?? '',
      locationDetails: json['locationDetails'] ?? '',
      capacity: json['capacity'] ?? 0,
      mainUse: json['mainUse'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      image: json['image'] ?? '',
      dataAiHint: json['dataAiHint'] ?? '',
      milestones: List<String>.from(json['milestones'] ?? []),
      photosByEra: List<String>.from(json['photosByEra'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'officialName': officialName,
      'city': city,
      'locationDetails': locationDetails,
      'capacity': capacity,
      'mainUse': mainUse,
      'shortDescription': shortDescription,
      'image': image,
      'dataAiHint': dataAiHint,
      'milestones': milestones,
      'photosByEra': photosByEra,
    };
  }
} 