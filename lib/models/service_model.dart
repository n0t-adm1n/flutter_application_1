import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String id;
  final String branchId;
  final String name;
  final String category;
  final String description;
  final double price;
  final int duration;
  final String image;
  final bool isActive;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.branchId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.image,
    required this.isActive,
    required this.createdAt,
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return ServiceModel(
      id: doc.id,
      branchId: data['branchId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      duration: data['duration'] as int? ?? 0,
      image: data['image'] as String? ?? '',
      isActive: data['isActive'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'branchId': branchId,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'duration': duration,
      'image': image,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
