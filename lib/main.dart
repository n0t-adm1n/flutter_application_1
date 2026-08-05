import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'core/theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/complete_profile_screen.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuxeBeauty',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: child!,
        );
      },
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppTheme.cream,
            body: Center(child: CircularProgressIndicator(color: AppTheme.charcoal)),
          );
        }

        final user = authSnapshot.data;
        if (user == null) {
          return const LoginScreen();
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('customers').doc(user.uid).snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: AppTheme.cream,
                body: Center(child: CircularProgressIndicator(color: AppTheme.charcoal)),
              );
            }

            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              // Wait for login screen to create the document
              return const Scaffold(
                backgroundColor: AppTheme.cream,
                body: Center(child: CircularProgressIndicator(color: AppTheme.charcoal)),
              );
            }

            final data = userSnapshot.data!.data() as Map<String, dynamic>?;
            final phoneNumber = data?['phoneNumber'] as String?;
            final address = data?['address'] as String?;

            if (phoneNumber == null || phoneNumber.trim().isEmpty || address == null || address.trim().isEmpty) {
              return const CompleteProfileScreen();
            }

            return const HomeScreen();
          },
        );
      },
    );
  }
}
