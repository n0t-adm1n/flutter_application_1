import 'package:flutter/material.dart';
import '../../core/theme.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        backgroundColor: AppTheme.cream,
        elevation: 0,
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.charcoal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Book Appointment'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildServiceSummary(context),
                const SizedBox(height: 32),
                _buildStylistSelector(context),
                const SizedBox(height: 32),
                _buildDateTimeMatrix(context),
              ],
            ),
          ),
          _buildBottomCheckoutSheet(context),
        ],
      ),
    );
  }

  Widget _buildServiceSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBDQ6YTzv0JrpgWuNCX40ci8cn_h9oXX31_k8zj9Hbasl2PQ_-LwKZAxJl1lywitOeFBgznVifxUVHeO2zEah1-JmPdLAxByDvgPwNpfpca_Qh8-RjGrNxS__ipOwgWE5nREGzeYQBzURFq50fL8bA9m13T0iU5ntwVABfgWzvY4K3tU5zdXttRz_QlMsgDmszHsN2y2V62840X4JbXFUrNMaB5nI9ZVnngDzacCrwUALYncqpgv6VPgJ4xy-lolh6IH0LsV79hDrn1',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceGray,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Hair Styling',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Balayage & Blowout', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '120 mins',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStylistSelector(BuildContext context) {
    final stylists = [
      {
        'name': 'Emma',
        'role': 'Senior Stylist',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDLxILBRtEEiQu5svTGWf3TNKFyn5t6Y-7ZJEl_BBZo25oI_uPXI2UnywZqrQ6bkvAp8qPNjy0XdkrNPJ0Fmdtk3LVhKQ1Y6AMl9loAFwtJArw0HGxoaUNz8Ch5bSJM0tpDKcy9m0aaHoH4gBXJjxA50MNDgM4n033L3n04SuPHUMCMAXvOz9Mb_IiOc7JygwsryusLwKLPdLUKqudXH8kNC4GOCwdfuHLtGpTG8hSHR6wQzaB7IcIySI6TXl9_8p6Rgt1ujSseiCZn',
        'selected': true,
      },
      {
        'name': 'Liam',
        'role': 'Master Colorist',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCSP_HSXT-mrt9n1Pea2vlnGNuVjknb6G8lM6y2a2cuIN5YSWFl2WEs-3BEY1cuOvLoGw7cYWunEEbJAkQXqyR8IIVd-yraVkhgB6j64n4xb2oeQIr9DgQM2BOvjqs816exdIjKpVaUuJ9anOcgR2SEwwg40d92261Cwse_uBlwMSzRSTrtdEVJPYMQpPFmr8jerVpyyiggsHmhfUYHAilfhKfiw7o6vhG3VJmmPvpA2cgqDJHJ2YVEpeYlPzdoHdVYHdw0ujkheJsG',
        'selected': false,
      },
      {
        'name': 'Sophia',
        'role': 'Stylist',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDPGTTGZsJnb3OmbJuJNHOF6OrSthLwIojcWhOUefWa7FVBzikNWaCBb1a2UVR3WCz3kWwT1z1X2u_Sf_JVL8IdxFQgoOVljNVao1HGR3kexRfNDqIG7UL9gpMKoljAQJuu37x_rg8D3n5MuAteSwjNq8i-2l9ErjbmDpzon9P5QiHBC-JwNiHe9XPXti6zzo6W8H7VkGX4J9jQleXLJG0JFfK0EM80kaqQbkKFmaneYiXVAU4NGMY43bTlCDzDecUAkemMfyCqpcu8',
        'selected': false,
      },
      {
        'name': 'Anyone',
        'role': 'Available',
        'image': null,
        'selected': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Stylist', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: stylists.map((stylist) {
              final isSelected = stylist['selected'] as bool;
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.surfaceGray : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppTheme.charcoal : Colors.transparent,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if (stylist['image'] != null)
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(stylist['image'] as String),
                          )
                        else
                          const CircleAvatar(
                            radius: 32,
                            backgroundColor: AppTheme.surfaceGray,
                            child: Icon(Icons.person, color: Colors.grey),
                          ),
                        if (isSelected)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check_circle, color: AppTheme.charcoal, size: 20),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(stylist['name'] as String, style: Theme.of(context).textTheme.labelLarge),
                    Text(
                      stylist['role'] as String,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
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

  Widget _buildDateTimeMatrix(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Date & Time', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        // Dates
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildDateItem(context, 'Mon', '12', false),
              _buildDateItem(context, 'Tue', '13', true),
              _buildDateItem(context, 'Wed', '14', false),
              _buildDateItem(context, 'Thu', '15', false),
              _buildDateItem(context, 'Fri', '16', false),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Morning
        Row(
          children: [
            const Icon(Icons.light_mode, size: 18, color: Colors.grey),
            const SizedBox(width: 4),
            Text('Morning', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildTimeItem(context, '09:00 AM', false, false),
            _buildTimeItem(context, '09:30 AM', false, false),
            _buildTimeItem(context, '10:00 AM', false, true),
            _buildTimeItem(context, '10:30 AM', true, false),
            _buildTimeItem(context, '11:00 AM', false, false),
            _buildTimeItem(context, '11:30 AM', false, false),
          ],
        ),
        const SizedBox(height: 24),
        // Afternoon
        Row(
          children: [
            const Icon(Icons.wb_sunny, size: 18, color: Colors.grey),
            const SizedBox(width: 4),
            Text('Afternoon', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildTimeItem(context, '12:00 PM', false, false),
            _buildTimeItem(context, '12:30 PM', false, false),
            _buildTimeItem(context, '01:00 PM', false, true),
            _buildTimeItem(context, '01:30 PM', false, true),
            _buildTimeItem(context, '02:00 PM', false, false),
          ],
        ),
      ],
    );
  }

  Widget _buildDateItem(BuildContext context, String day, String date, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 64,
      height: 80,
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.charcoal : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? AppTheme.charcoal : Colors.transparent),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isSelected ? Colors.white70 : Colors.grey,
                ),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: isSelected ? Colors.white : AppTheme.charcoal,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeItem(BuildContext context, String time, bool isSelected, bool isDisabled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.charcoal : (isDisabled ? Colors.grey[200] : Colors.white),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppTheme.charcoal : Colors.transparent,
        ),
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected
                  ? Colors.white
                  : (isDisabled ? Colors.grey : AppTheme.charcoal),
              decoration: isDisabled ? TextDecoration.lineThrough : null,
            ),
      ),
    );
  }

  Widget _buildBottomCheckoutSheet(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 40,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 48, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service Fee:', style: Theme.of(context).textTheme.bodyMedium),
                Text('₹1,200', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Platform Fee:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                Text('₹25', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Partial Advance Deposit:', style: Theme.of(context).textTheme.headlineSmall),
                Text('₹300', style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.charcoal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Proceed to Secure Pay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  const Icon(Icons.lock, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Remaining ₹925 to be paid at venue.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
