import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createBooking(Booking booking) async {
    try {
      String id = booking.id;
      if (id.isEmpty) {
        id = _firestore.collection('bookings').doc().id;
      }
      await _firestore.collection('bookings').doc(id).set(booking.toFirestore());
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }
}
