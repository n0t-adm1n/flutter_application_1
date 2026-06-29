import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../widgets/cards.dart';
import '../salon_profile/salon_profile_screen.dart';
import '../profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMobileHeader(context),
            const SizedBox(height: 24),
            _buildSearchFilter(),
            const SizedBox(height: 40),
            _buildCategories(context),
            const SizedBox(height: 40),
            _buildFeaturedSalons(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return AppBar(
      backgroundColor: AppTheme.cream,
      elevation: 0,
      scrolledUnderElevation: 2,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(Icons.location_on, color: AppTheme.charcoal),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT LOCATION',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                'Sector 62, Noida',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: user?.photoURL != null 
                    ? NetworkImage(user!.photoURL!) 
                    : null,
                backgroundColor: Colors.grey[300],
                child: user?.photoURL == null ? const Icon(Icons.person, color: Colors.grey) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LuxeBeauty',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Discover premium beauty & wellness.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildSearchFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search salons, stylists...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.charcoal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'icon': Icons.content_cut, 'label': 'Haircut'},
      {'icon': Icons.face_retouching_natural, 'label': 'Facial'},
      {'icon': Icons.brush, 'label': 'Makeup'},
      {'icon': Icons.dry_cleaning, 'label': 'Nails'},
      {'icon': Icons.spa, 'label': 'Spa'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Explore Services', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Row(
            children: categories.map((cat) {
              return Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppTheme.roseGold.withOpacity(0.05),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Icon(cat['icon'] as IconData,
                          color: AppTheme.roseGold, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cat['label'] as String,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSalons(BuildContext context) {
    final salons = [
      {
        'title': 'Aesthetic Aura Salon',
        'subtitle': '(120+ reviews) • 1.2 km away',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDOAn8_CVoyho4d7_7wY08NM-BfuKa0KlfFZEHcI0qKLVD0De4ASHsn_kWhdOEkRDDSSthW1b7tgjETa-pKPe6WEtZJ_-gprdk0r_MZ_f8dO0xFBkGHqwxJOlpz92Zf319p16m2fUxVXdKKxd12hNU_aXR8u54ASXIcMKH1_HD738YtUj1yypu18TfMaiV6a64lrQRUGAAXQsLyZNu-Mbb55pYLChG-qaHJ5ko6tM0oEdK1xawPekPYo8Qci-gtTxpX1f-dDBxNY3Om',
        'badge': 'TOP RATED',
      },
      {
        'title': 'The Serenity Spa',
        'subtitle': '(85+ reviews) • 2.5 km away',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAuIDDM6xhwQaAuAfVOKeCal15utAqrDYIh-AKH8IijJ7SQiS2f3KFrTL0HAgaJ3WQCFGMy8kkLVrqkNaXjpCQ_5Y7ZqApBW4CB_UwMBGhkwYNnsHwCF7fh4XYCV5au2OQSGw2xtNWjxIObxS-HO3yv-AX8A9_bY4QTRImujtlv9d8ZAp87ydL3mtIMmdkB_kAVkBmnvtFvPfx9GP_8hi0j38O-AKxjOWhKAfZB6PR20Asrgm-gvY2Taqpfp8PmiahHtKNyinmKtujd',
        'badge': null,
      },
      {
        'title': 'Gloss & Glamour',
        'subtitle': '(40+ reviews) • 3.0 km away',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTV7uYiP97WMnOyhETw2X4mimwnno5ed2g4DK4xvWioZ5iIAA9yogJ1C7q5ldkvHEPbzQdyhYAxH5mCh2PdTIdl5_9rmpBgraYb3bXtwCdLU76Zlz-I5Z7u-R6ymJU8SHUJe6uyegw5rug3v-j9vLyYPYg3aEWzgxMAQuU4_8hEZebvw5Rn_8IP3xnwkuLqVA00DGCRud0kuY3z8uRaWS2m_wZedbyxeNDWfgxN1xMPpJTWaip5G1uept8b8VpIgPD7gGXMlXHJtm',
        'badge': 'NEW',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured Salons',
                style: Theme.of(context).textTheme.headlineSmall),
            TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.roseGold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...salons.map((salon) => MarketplaceCard(
              title: salon['title'] as String,
              subtitle: salon['subtitle'] as String,
              imageUrl: salon['imageUrl'] as String,
              badgeText: salon['badge'] as String?,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalonProfileScreen()),
                );
              },
            )),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppTheme.charcoal,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
