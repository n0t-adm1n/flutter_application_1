import 'package:flutter/material.dart';
import '../core/theme.dart';

class MarketplaceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? badgeText;
  final String? vendorType;
  final VoidCallback? onTap;

  const MarketplaceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.badgeText,
    this.vendorType,
    this.onTap,
  });

  Widget _buildVendorBadge(String type) {
    final isFreelancer = type == 'freelancer';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isFreelancer ? Colors.purple.shade50 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isFreelancer ? Colors.purple.shade200 : Colors.teal.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFreelancer ? Icons.home : Icons.store,
            size: 14,
            color: isFreelancer ? Colors.purple : Colors.teal,
          ),
          const SizedBox(width: 4),
          Text(
            isFreelancer ? 'Home Service' : 'At Salon',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isFreelancer ? Colors.purple : Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image with 16:9 ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[300]),
                  ),
                  if (badgeText != null)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.coral.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          badgeText!,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (vendorType != null) ...[
                    const SizedBox(height: 8),
                    _buildVendorBadge(vendorType!),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
