
import 'package:flutter/material.dart';
import 'package:mausamie/models/WeatherModel.dart';

class WeatherInfoCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfoCard({
    super.key,
    required this.weather,
  });

  IconData get conditionIcon {
    final condition = weather.condition.main.toLowerCase();

    if (condition.contains('thunderstorm')) {
      return Icons.thunderstorm_rounded;
    }
    if (condition.contains('rain') ||
        condition.contains('drizzle')) {
      return Icons.water_drop_rounded;
    }
    if (condition.contains('cloud')) {
      return Icons.cloud_rounded;
    }
    if (condition.contains('snow')) {
      return Icons.ac_unit_rounded;
    }
    if (condition.contains('clear')) {
      return Icons.wb_sunny_rounded;
    }
    if (condition.contains('mist') ||
        condition.contains('fog') ||
        condition.contains('haze')) {
      return Icons.cloud_queue_rounded;
    }

    return Icons.wb_cloudy_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth >= 600;

    final cardPadding = isSmallScreen
        ? 14.0
        : isTablet
            ? 28.0
            : 22.0;

    final cityFontSize = isSmallScreen ? 19.0 : 23.0;
    final temperatureFontSize = isSmallScreen ? 39.0 : 49.0;
    final iconSize = isSmallScreen ? 48.0 : isTablet ? 75.0 : 65.0;
    final gap = isSmallScreen ? 12.0 : 20.0;

    final description = weather.condition.description;

    final formattedDescription = description.isNotEmpty
        ? '${description[0].toUpperCase()}${description.substring(1)}'
        : 'Weather';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF193653).withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${weather.cityName}, ${weather.countryName}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: cityFontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: isSmallScreen ? 14 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                conditionIcon,
                size: iconSize,
                color: const Color(0xFFFFD166),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${weather.data.temp.round()}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: temperatureFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFFC6D8EA),
                        fontSize: isSmallScreen ? 12 : 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
