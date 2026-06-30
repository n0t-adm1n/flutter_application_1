// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceModel>> getServicesByBranch(String branchId) async {
    try {
      final querySnapshot = await _firestore
          .collection('services')
          .where('branchId', isEqualTo: branchId)
          .where('isActive', isEqualTo: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching services for branch: $e');
      return [];
    }
  }
}
