import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../widgets/buttons.dart';
import '../../core/theme.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authService = AuthService();

    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppTheme.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user?.photoURL != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.photoURL!),
                )
              else
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
              const SizedBox(height: 24),
              Text(
                user?.displayName ?? 'Guest User',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.charcoal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? 'No email linked',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),
              PrimaryButton(
                text: 'Log Out',
                onPressed: () async {
                  await authService.signOut();
                  // The StreamBuilder in main.dart will automatically
                  // detect the state change and route back to LoginScreen.
                  // But we pop until root so the StreamBuilder handles it cleanly.
                  if (context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
