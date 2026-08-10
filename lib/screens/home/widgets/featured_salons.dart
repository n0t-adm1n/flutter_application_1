import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/theme.dart';
import '../../../widgets/cards.dart';
import '../../branch_detail/branch_detail_screen.dart';
import '../../../models/branch_model.dart';

class FeaturedSalons extends StatelessWidget {
  final String selectedCity;
  final List<DocumentSnapshot> parlors;
  final bool isLoading;

  const FeaturedSalons({
    super.key,
    required this.selectedCity,
    required this.parlors,
    required this.isLoading,
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
        if (parlors.isEmpty && !isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text('No beauty parlors found in your area.'),
          )
        else
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: parlors.length,
                itemBuilder: (context, index) {
                  final branch = Branch.fromFirestore(parlors[index]);
                  return MarketplaceCard(
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
                  );
                },
              ),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
      ],
    );
  }
}
