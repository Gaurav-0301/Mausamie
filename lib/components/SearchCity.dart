
import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback? onCurrentLocation;

  const SearchCity({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onCurrentLocation,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth >= 600;

    final barHeight = isSmallScreen ? 48.0 : 54.0;
    final horizontalPadding = isSmallScreen ? 10.0 : 16.0;
    final iconSize = isSmallScreen ? 21.0 : 25.0;
    final gap = isSmallScreen ? 8.0 : 12.0;
    final textSize = isTablet ? 17.0 : 15.0;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isTablet ? 650 : double.infinity,
      ),
      height: barHeight,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onCurrentLocation,
            tooltip: 'Get current location weather',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.my_location_rounded,
              color: const Color(0xFF168BFF),
              size: iconSize,
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSearch(),
              style: TextStyle(
                fontSize: textSize,
                color: const Color(0xFF172A40),
              ),
              decoration: InputDecoration(
                hintText: 'Enter city name...',
                hintStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: textSize,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(
            width: isSmallScreen ? 40 : 48,
            child: IconButton(
              onPressed: onSearch,
              padding: EdgeInsets.zero,
              tooltip: 'Search city',
              icon: Icon(
                Icons.search_rounded,
                color: const Color(0xFF168BFF),
                size: isSmallScreen ? 24 : 27,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
