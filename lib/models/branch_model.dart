import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  final String id;
  final String businessId;
  final String name;
  final String city;
  final GeoPoint location;
  final String geohash;
  final String timezone;
  final double rating;
  final int reviewCount;
  final Map<String, dynamic> workingHours;
  final bool isActive;
  final DateTime updatedAt;

  Branch({
    required this.id,
    required this.businessId,
    required this.name,
    required this.city,
    required this.location,
    required this.geohash,
    required this.timezone,
    required this.rating,
    required this.reviewCount,
    required this.workingHours,
    required this.isActive,
    required this.updatedAt,
  });

  factory Branch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    // Safely parse double and int
    final rawRating = data['rating'];
    final ratingValue = rawRating is num ? rawRating.toDouble() : 0.0;
    
    final reviewCountValue = data['reviewCount'] as int? ?? 0;

    // Safely parse GeoPoint
    final rawLocation = data['location'];
    final locationValue = rawLocation is GeoPoint ? rawLocation : const GeoPoint(0.0, 0.0);

    // Safely parse DateTime from Firestore Timestamp
    final rawUpdatedAt = data['updatedAt'];
    final updatedAtValue = rawUpdatedAt is Timestamp ? rawUpdatedAt.toDate() : DateTime.now();

    // Safely parse map
    final workingHoursMap = data['workingHours'] is Map
        ? Map<String, dynamic>.from(data['workingHours'] as Map)
        : <String, dynamic>{};

    return Branch(
      id: doc.id,
      businessId: data['businessId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      city: data['city'] as String? ?? '',
      location: locationValue,
      geohash: data['geohash'] as String? ?? '',
      timezone: data['timezone'] as String? ?? '',
      rating: ratingValue,
      reviewCount: reviewCountValue,
      workingHours: workingHoursMap,
      isActive: data['isActive'] as bool? ?? false,
      updatedAt: updatedAtValue,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'businessId': businessId,
      'name': name,
      'city': city,
      'location': location,
      'geohash': geohash,
      'timezone': timezone,
      'rating': rating,
      'reviewCount': reviewCount,
      'workingHours': workingHours,
      'isActive': isActive,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
