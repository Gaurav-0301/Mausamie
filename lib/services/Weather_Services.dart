
import 'dart:convert';
import 'package:mausamie/models/WeatherModel.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  final baseUrl = "https://api.openweathermap.org/data/2.5";
  final apiId = "c9b2f8ad8a97a4ad2c80f3557289c4ac";

  Future<WeatherModel> getWeatherData(String cityName) async {
    final url = Uri.parse(
      "$baseUrl/weather?q=${Uri.encodeQueryComponent(cityName)}"
      "&appid=$apiId&units=metric",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return WeatherModel.fromJson(jsonData);
      }

      if (response.statusCode == 404) {
        throw Exception("City not found. Please enter a valid city.");
      }

      if (response.statusCode == 401) {
        throw Exception("Invalid API key.");
      }

      throw Exception("Unable to fetch weather. Try again later.");
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception("Network error. Check your internet connection.");
    }
  }

  Future<WeatherModel> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    final url = Uri.parse(
      "$baseUrl/weather?lat=$latitude&lon=$longitude"
      "&appid=$apiId&units=metric",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return WeatherModel.fromJson(jsonData);
      }

      if (response.statusCode == 404) {
        throw Exception("Weather data for this location was not found.");
      }

      if (response.statusCode == 401) {
        throw Exception("Invalid API key.");
      }

      throw Exception("Unable to fetch weather for your location. Try again later.");
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception("Network error. Check your internet connection.");
    }
  }
}
