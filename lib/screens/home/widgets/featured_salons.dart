import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/theme.dart';
import '../../../widgets/cards.dart';
import '../../branch_detail/branch_detail_screen.dart';
import '../../../models/branch_model.dart';

class FeaturedSalons extends StatelessWidget {
  final String selectedCity;
  final String searchQuery;

  const FeaturedSalons({
    super.key,
    required this.selectedCity,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
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
        StreamBuilder<QuerySnapshot>(
          stream: searchQuery.isEmpty
              ? FirebaseFirestore.instance.collection('branches').where('city', isEqualTo: selectedCity).snapshots()
              : FirebaseFirestore.instance.collection('branches').where('city', isEqualTo: selectedCity).where('searchName', isGreaterThanOrEqualTo: searchQuery).where('searchName', isLessThan: '${searchQuery}z').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text('No beauty parlors found in your area.'),
              );
            }

            final branches = snapshot.data!.docs.map((doc) => Branch.fromFirestore(doc)).toList();

            return Column(
              children: branches.map((branch) => MarketplaceCard(
                title: branch.name,
                subtitle: '(${branch.reviewCount}+ reviews) • ${branch.city}',
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDOAn8_CVoyho4d7_7wY08NM-BfuKa0KlfFZEHcI0qKLVD0De4ASHsn_kWhdOEkRDDSSthW1b7tgjETa-pKPe6WEtZJ_-gprdk0r_MZ_f8dO0xFBkGHqwxJOlpz92Zf319p16m2fUxVXdKKxd12hNU_aXR8u54ASXIcMKH1_HD738YtUj1yypu18TfMaiV6a64lrQRUGAAXQsLyZNu-Mbb55pYLChG-qaHJ5ko6tM0oEdK1xawPekPYo8Qci-gtTxpX1f-dDBxNY3Om', // Placeholder image
                badgeText: branch.rating > 4.5 ? 'TOP RATED' : null,
                vendorType: branch.vendorType,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BranchDetailScreen(branchId: branch.id),
                    ),
                  );
                },
              )).toList(),
            );
          },
        ),
      ],
    );
  }
}
