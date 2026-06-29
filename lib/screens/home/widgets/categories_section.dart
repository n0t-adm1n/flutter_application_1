import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}
