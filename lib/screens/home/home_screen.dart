import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/mobile_header.dart';
import 'widgets/search_filter.dart';
import 'widgets/categories_section.dart';
import 'widgets/featured_salons.dart';
import 'widgets/home_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCity = 'Lucknow';
  final List<String> _availableCities = const ['Lucknow', 'Kanpur'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: HomeAppBar(
        selectedCity: _selectedCity,
        availableCities: _availableCities,
        onCityChanged: (newCity) {
          setState(() {
            _selectedCity = newCity;
          });
        },
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MobileHeader(),
            const SizedBox(height: 24),
            const SearchFilter(),
            const SizedBox(height: 40),
            const CategoriesSection(),
            const SizedBox(height: 40),
            FeaturedSalons(selectedCity: _selectedCity),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
