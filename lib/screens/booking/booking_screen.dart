import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/theme.dart';
import '../../models/service_model.dart';
import '../../models/booking_model.dart';
import '../../repositories/booking_repository.dart';

class BookingScreen extends StatefulWidget {
  final String branchId;
  final String branchName;
  final List<ServiceModel> selectedServices;
  final int totalDuration;
  final String vendorType;
  final String branchAddress;

  const BookingScreen({
    super.key,
    required this.branchId,
    required this.branchName,
    required this.vendorType,
    required this.branchAddress,
    required this.selectedServices,
    required this.totalDuration,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  bool _isLoading = false;
  final TextEditingController _customerAddressController = TextEditingController();

  @override
  void dispose() {
    _customerAddressController.dispose();
    super.dispose();
  }

  final List<String> timeSlots = [
    '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
    '12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM',
    '02:00 PM', '02:30 PM', '03:00 PM', '03:30 PM',
    '04:00 PM', '04:30 PM', '05:00 PM', '05:30 PM',
    '06:00 PM'
  ];

  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Select Date & Time', style: TextStyle(color: AppTheme.charcoal)),
        backgroundColor: AppTheme.cream,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.charcoal),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.branchName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.charcoal,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = selectedDate != null && 
                    selectedDate!.year == date.year && 
                    selectedDate!.month == date.month && 
                    selectedDate!.day == date.day;
                
                String month = months[date.month - 1];
                String weekday = weekdays[date.weekday - 1];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.charcoal : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppTheme.charcoal : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          month,
                          style: TextStyle(
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppTheme.charcoal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          weekday,
                          style: TextStyle(
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Available Times',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          // TODO: Replace hardcoded time slots with dynamic availability calculation based on branch working hours and existing Firestore bookings
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final slot = timeSlots[index];
                final isSelected = selectedTimeSlot == slot;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeSlot = slot;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.charcoal : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppTheme.charcoal : Colors.grey[300]!,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      slot,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.charcoal,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: (selectedDate != null && selectedTimeSlot != null)
          ? Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.vendorType == 'freelancer')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _customerAddressController,
                          decoration: const InputDecoration(
                            labelText: 'Your Service Address',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Salon Address: ${widget.branchAddress}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () async {
                          if (selectedDate == null || selectedTimeSlot == null) return;
                          
                          if (widget.vendorType == 'freelancer' && _customerAddressController.text.trim().isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter your service address.')),
                              );
                            }
                            return;
                          }
                          
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please log in to confirm your booking.')),
                              );
                            }
                            return;
                          }

                          setState(() => _isLoading = true);

                    try {
                      // Parse time: "10:30 AM"
                      final timeParts = selectedTimeSlot!.split(' ');
                      final hm = timeParts[0].split(':');
                      int hour = int.parse(hm[0]);
                      int minute = int.parse(hm[1]);
                      final isPM = timeParts[1] == 'PM';
                      
                      if (isPM && hour != 12) hour += 12;
                      if (!isPM && hour == 12) hour = 0;

                      final bookingNumber = DateTime.now().millisecondsSinceEpoch.toString();
                      final bookingDateLocal = '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}';

                      final startTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        hour,
                        minute,
                      );
                      
                      final endTime = startTime.add(Duration(minutes: widget.totalDuration));

                      final customerSnapshot = {
                        'uid': user.uid,
                        'name': user.displayName ?? 'Customer',
                        'email': user.email ?? '',
                      };

                      final servicesSnapshot = widget.selectedServices.map((s) => s.toFirestore()).toList();
                      final totalPrice = widget.selectedServices.fold(0.0, (sum, item) => sum + item.price);

                      final booking = Booking(
                        id: '', 
                        customerUid: user.uid,
                        branchId: widget.branchId,
                        bookingNumber: bookingNumber,
                        bookingDateLocal: bookingDateLocal,
                        startTime: startTime,
                        endTime: endTime,
                        totalPrice: totalPrice,
                        status: BookingStatus.pending,
                        paymentStatus: PaymentStatus.pending,
                        customerSnapshot: customerSnapshot,
                        servicesSnapshot: servicesSnapshot,
                        serviceLocation: widget.vendorType == 'freelancer' ? 'at_home' : 'at_parlor',
                        customerAddress: widget.vendorType == 'freelancer' ? _customerAddressController.text : '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      await BookingRepository().createBooking(booking);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking Confirmed!')),
                        );
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    } finally {
                      if (context.mounted) {
                        setState(() => _isLoading = false);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.charcoal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading 
                      ? const SizedBox(
                          height: 20, 
                          width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Text('Confirm Booking', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
