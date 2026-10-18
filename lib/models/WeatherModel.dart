import 'package:mausamie/models/MainWeatherData.dart';
import 'package:mausamie/models/WeatherCondition.dart';

class WeatherModel {
  final String cityName;
  final String countryName;
  final WeatherCondition condition;
  final MainWeatherData data;

  WeatherModel(
    {
      required this.cityName, 
      required this.countryName,
       required this.condition,
        required this.data
        });
}
