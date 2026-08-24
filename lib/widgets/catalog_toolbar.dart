import 'package:flutter/material.dart';

import 'app_text_field.dart';

class CatalogToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback onFilterPressed;

  const CatalogToolbar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: searchController,
              hintText: 'Cari produk',
              prefixIcon: Icons.search,
              onChanged: onSearchChanged,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onFilterPressed,
              icon: const Icon(Icons.tune),
              tooltip: 'Filter dan urutakn',
            ),
          ),
        ],
      ),
    );
  }
}
