
import 'package:flutter/material.dart';
import 'package:mausamie/models/WeatherModel.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetails({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final data = weather.data;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth >= 600;

    final columns = isTablet ? 4 : 2;
    final aspectRatio = isTablet
        ? 0.95
        : isSmallScreen
            ? 1.25
            : 1.45;

    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: aspectRatio,
      children: [
        _detail(
          Icons.thermostat_rounded,
          'Feels like',
          '${data.feels_like.round()}°C',
          isSmallScreen,
        ),
        _detail(
          Icons.water_drop_outlined,
          'Humidity',
          '${data.humidity}%',
          isSmallScreen,
        ),
        _detail(
          Icons.speed_rounded,
          'Pressure',
          '${data.pressure} hPa',
          isSmallScreen,
        ),
        _detail(
          Icons.device_thermostat_rounded,
          'Min / Max',
          '${data.temp_min.round()}° / ${data.temp_max.round()}°',
          isSmallScreen,
        ),
      ],
    );
  }

  Widget _detail(
    IconData icon,
    String title,
    String value,
    bool isSmallScreen,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 9 : 12),
      decoration: BoxDecoration(
        color: const Color(0xFF172A40).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF80D6FF),
            size: isSmallScreen ? 20 : 23,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFFADC0D4),
              fontSize: isSmallScreen ? 11 : 12,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 16 : 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
