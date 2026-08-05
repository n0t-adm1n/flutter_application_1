import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

            if (userSnapshot.hasError) {
              return Scaffold(
                backgroundColor: AppTheme.cream,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading profile',
                        style: TextStyle(color: AppTheme.charcoal),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (!userSnapshot.hasData) {
              return const Scaffold(
                backgroundColor: AppTheme.cream,
                body: Center(child: CircularProgressIndicator(color: AppTheme.charcoal)),
              );
            }

            if (!userSnapshot.data!.exists) {
              return const CompleteProfileScreen();
            }

            final data = userSnapshot.data!.data() as Map<String, dynamic>?;
            final name = data?['name'] as String?;
            final phoneNumber = data?['phoneNumber'] as String?;
            final address = data?['address'] as String?;
            final city = data?['city'] as String?;

            if (name == null || name.trim().isEmpty ||
                phoneNumber == null || phoneNumber.trim().isEmpty || 
                address == null || address.trim().isEmpty ||
                city == null || city.trim().isEmpty) {
              return const CompleteProfileScreen();
            }

            return const HomeScreen();
          },
        );
      },
    );
  }
}
