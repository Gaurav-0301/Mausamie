
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

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: [
        _detail(
          Icons.thermostat_rounded,
          'Feels like',
          '${data.feels_like.round()}°C',
        ),
        _detail(
          Icons.water_drop_outlined,
          'Humidity',
          '${data.humidity}%',
        ),
        _detail(
          Icons.speed_rounded,
          'Pressure',
          '${data.pressure} hPa',
        ),
        _detail(
          Icons.device_thermostat_rounded,
          'Min / Max',
          '${data.temp_min.round()}° / ${data.temp_max.round()}°',
        ),
      ],
    );
  }

  Widget _detail(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            size: 23,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFADC0D4),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
