import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_service.dart';
import '../../widgets/buttons.dart';
import '../../core/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authService = AuthService();

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }

    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppTheme.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('customers').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.charcoal));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;
          final name = userData?['name'] as String? ?? user.displayName ?? 'Guest User';
          final phone = userData?['phoneNumber'] as String? ?? 'No phone number';

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user.photoURL != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoURL!),
                    )
                  else
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.charcoal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? 'No email linked',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        phone,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.charcoal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: AppTheme.charcoal),
                        onPressed: () {
                          _showEditPhoneDialog(context, user.uid, phone);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  PrimaryButton(
                    text: 'Log Out',
                    onPressed: () async {
                      await authService.signOut();
                      if (context.mounted) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditPhoneDialog(BuildContext context, String uid, String currentPhone) {
    final phoneController = TextEditingController(text: currentPhone);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cream,
          title: const Text('Edit Phone Number', style: TextStyle(color: AppTheme.charcoal)),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a mobile number';
                }
                final phoneRegex = RegExp(r'^[6-9]\d{9}$');
                if (!phoneRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid 10-digit Indian mobile number';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.charcoal)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.charcoal),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await FirebaseFirestore.instance.collection('customers').doc(uid).update({
                    'phoneNumber': phoneController.text.trim(),
                  });
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Save', style: TextStyle(color: AppTheme.cream)),
            ),
          ],
        );
      },
    );
  }
}
