import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../widgets/cards.dart';
import '../../salon_profile/salon_profile_screen.dart';

class FeaturedSalons extends StatelessWidget {
  const FeaturedSalons({super.key});

  @override
  Widget build(BuildContext context) {
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
}
