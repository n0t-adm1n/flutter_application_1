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
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            SearchFilter(searchController: _searchController),
            const SizedBox(height: 40),
            const CategoriesSection(),
            const SizedBox(height: 40),
            FeaturedSalons(selectedCity: _selectedCity, searchQuery: _searchQuery),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
