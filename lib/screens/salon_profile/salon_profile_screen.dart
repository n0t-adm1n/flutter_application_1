import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../widgets/buttons.dart';
import '../booking/booking_screen.dart';

class SalonProfileScreen extends StatelessWidget {
  const SalonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSalonDetails(context),
                  const SizedBox(height: 24),
                  _buildTabBar(context),
                  const SizedBox(height: 24),
                  _buildServiceList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.cream,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.charcoal),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: AppTheme.coral),
              onPressed: () {},
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAyRTwQfSH-mQqWJYCAnXkn69jKH2Ga0ytG6hrQMzrV7kNh4rWPQAI1SuV_YlZrgK_6-JK_oTGvu26p5KMvJZ4bEeSTg7uamBGIxb39CGgxDdjAXkkJYQI3YRV3czNOclzTMH-iuhy9tfM_HIrmDRD4WmWJGuaJ1Tci0kBHhNU8x0zcJdpocZ8nMBXF83cEXx9NhvCymf_Nsnr_RBak3obouc8MWnTL5plmmIOhb-Z0juNlNHDwXck0E-5ilmQB3H2F319ZGWqDmTQu',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalonDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Velvet Room Salon',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '124 Madison Ave, New York',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Open Now',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.green[800],
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    '4.9',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(128 reviews)',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
        Column(
          children: [
            Text(
              'Services',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.charcoal,
                  ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 60,
              height: 2,
              color: AppTheme.charcoal,
            ),
          ],
        ),
        Text(
          'Portfolio',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          'Reviews',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildServiceList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured Services', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _buildServiceCard(
          context,
          title: 'Luxe Hair Spa',
          description:
              'A deeply nourishing treatment using premium oils to restore shine and vitality to damaged hair. Includes a relaxing scalp massage.',
          time: '45 mins',
          price: '₹1,200',
          isPopular: true,
        ),
        const SizedBox(height: 16),
        _buildServiceCard(
          context,
          title: 'Signature Balayage',
          description:
              'Hand-painted highlights tailored to your natural hair pattern for a seamless, sun-kissed look. Toner included.',
          time: '120 mins',
          price: '₹4,500',
          isPopular: false,
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required String time,
    required String price,
    required bool isPopular,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: Theme.of(context).textTheme.headlineSmall),
                    if (isPopular) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.amber.withOpacity(0.2)),
                        ),
                        child: Text(
                          'POPULAR',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.amber[800],
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.charcoal,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SecondaryButton(
            text: 'Add',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
