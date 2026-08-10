import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class SearchFilter extends StatelessWidget {
  final TextEditingController searchController;

  const SearchFilter({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search salons, stylists...',
                border: InputBorder.none,
                isDense: true,
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: searchController,
                  builder: (context, value, child) {
                    return value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              searchController.clear();
                            },
                          )
                        : const SizedBox.shrink();
                  },
                ),
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
}
