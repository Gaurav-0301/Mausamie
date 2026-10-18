
import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchCity({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_city, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => onSearch(),
                decoration: const InputDecoration(
                  hintText: 'e.g.,Nagpur,Wardha...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
