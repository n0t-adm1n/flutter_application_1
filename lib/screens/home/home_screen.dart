import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  List<DocumentSnapshot> _parlors = [];
  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSelectedCity();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _fetchParlors();
      }
    });

    _searchController.addListener(() {
      final newQuery = _searchController.text.trim().toLowerCase();
      if (_searchQuery != newQuery) {
        setState(() {
          _searchQuery = newQuery;
        });
        _resetAndFetch();
      }
    });
  }

  Future<void> _loadSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString('selectedCity');
    if (savedCity != null && _availableCities.contains(savedCity)) {
      setState(() {
        _selectedCity = savedCity;
      });
    }
    _fetchParlors();
  }

  Future<void> _fetchParlors() async {
    if (_isLoading || !_hasMore) return;
    
    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('branches')
        .where('city', isEqualTo: _selectedCity)
        .limit(10);

    if (_searchQuery.isNotEmpty) {
      query = query
          .where('searchName', isGreaterThanOrEqualTo: _searchQuery)
          .where('searchName', isLessThan: '${_searchQuery}z');
    }

    if (_lastDoc != null) {
      query = query.startAfterDocument(_lastDoc!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      _hasMore = false;
    } else {
      _parlors.addAll(snapshot.docs);
      _lastDoc = snapshot.docs.last;
      if (snapshot.docs.length < 10) {
        _hasMore = false;
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _resetAndFetch() {
    _parlors.clear();
    _lastDoc = null;
    _hasMore = true;
    _fetchParlors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: HomeAppBar(
        selectedCity: _selectedCity,
        availableCities: _availableCities,
        onCityChanged: (newCity) async {
          if (_selectedCity != newCity) {
            setState(() {
              _selectedCity = newCity;
            });
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('selectedCity', newCity);
            _resetAndFetch();
          }
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
            FeaturedSalons(
              selectedCity: _selectedCity,
              parlors: _parlors,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
