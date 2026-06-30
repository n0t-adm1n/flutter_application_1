// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/branch_model.dart';

class BranchRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Branch>> getActiveBranchesByCity(String city) async {
    try {
      final querySnapshot = await _firestore
          .collection('branches')
          .where('city', isEqualTo: city)
          .where('isActive', isEqualTo: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Branch.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching active branches by city: $e');
      return [];
    }
  }

  Future<Branch?> getBranchById(String id) async {
    try {
      final docSnapshot = await _firestore.collection('branches').doc(id).get();
      if (docSnapshot.exists) {
        return Branch.fromFirestore(docSnapshot);
      }
      return null;
    } catch (e) {
      print('Error fetching branch by ID: $e');
      return null;
    }
  }
}
