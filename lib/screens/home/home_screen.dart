import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../services/db_seeder.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/mobile_header.dart';
import 'widgets/search_filter.dart';
import 'widgets/categories_section.dart';
import 'widgets/featured_salons.dart';
import 'widgets/home_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MobileHeader(),
            SizedBox(height: 24),
            SearchFilter(),
            SizedBox(height: 40),
            CategoriesSection(),
            SizedBox(height: 40),
            FeaturedSalons(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DbSeeder.seedBranches();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dummy Data Injected!')),
            );
          }
        },
        child: const Icon(Icons.dataset),
      ),
    );
  }
}
