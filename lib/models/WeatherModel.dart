import 'package:mausamie/models/MainWeatherData.dart';
import 'package:mausamie/models/WeatherCondition.dart';

class WeatherModel {
  final String cityName;
  final String countryName;
  final WeatherCondition condition;
  final MainWeatherData data;
  final double latitude;
  final double longitude;

  WeatherModel({
    required this.cityName,
    required this.countryName,
    required this.condition,
    required this.data,
    required this.latitude,
    required this.longitude
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
    : cityName = json['name'].toString(),
      countryName = json['sys']['country'].toString(),
      condition = WeatherCondition.fromJson(json),
      data = MainWeatherData.fromJson(json),
      latitude = (json['coord']['lat'] as num).toDouble(),
      longitude = (json['coord']['lon'] as num).toDouble();
}
