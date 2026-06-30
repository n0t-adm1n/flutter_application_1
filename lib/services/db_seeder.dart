// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DbSeeder {
  static Future<void> seedBranches() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    final branchesRef = firestore.collection('branches');

    final workingHours = {
      'Monday': '09:00 AM - 08:00 PM',
      'Tuesday': '09:00 AM - 08:00 PM',
      'Wednesday': '09:00 AM - 08:00 PM',
      'Thursday': '09:00 AM - 08:00 PM',
      'Friday': '09:00 AM - 08:00 PM',
      'Saturday': '10:00 AM - 09:00 PM',
      'Sunday': '10:00 AM - 09:00 PM',
    };

    final branch1 = {
      'businessId': 'biz_001',
      'name': 'Glamour Studio',
      'city': 'Kanpur',
      'location': const GeoPoint(26.4499, 80.3319),
      'geohash': '',
      'timezone': 'Asia/Kolkata',
      'rating': 4.8,
      'reviewCount': 120,
      'workingHours': workingHours,
      'isActive': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final branch2 = {
      'businessId': 'biz_002',
      'name': 'Elegance Parlor',
      'city': 'Kanpur',
      'location': const GeoPoint(26.4600, 80.3200),
      'geohash': '',
      'timezone': 'Asia/Kolkata',
      'rating': 4.5,
      'reviewCount': 85,
      'workingHours': workingHours,
      'isActive': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final branch3 = {
      'businessId': 'biz_003',
      'name': 'The Velvet Touch Spa',
      'city': 'Kanpur',
      'location': const GeoPoint(26.4550, 80.3400),
      'geohash': '',
      'timezone': 'Asia/Kolkata',
      'rating': 4.9,
      'reviewCount': 210,
      'workingHours': workingHours,
      'isActive': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    batch.set(branchesRef.doc(), branch1);
    batch.set(branchesRef.doc(), branch2);
    batch.set(branchesRef.doc(), branch3);

    try {
      await batch.commit();
      print('Dummy branches seeded successfully!');
    } catch (e) {
      print('Error seeding branches: $e');
    }
  }
}
