
import 'dart:convert';
import 'package:mausamie/models/WeatherModel.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  final baseUrl = "https://api.openweathermap.org/data/2.5";
  final apiId = "c9b2f8ad8a97a4ad2c80f3557289c4ac";

  Future<WeatherModel?> getWeatherData(String cityName) async {
    try {
      var url =
          "$baseUrl/weather?q=$cityName&appid=$apiId&units=metric";

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return WeatherModel.fromJson(jsonData);
      }

      print("Error: ${response.statusCode}");
      print(response.body);
      return null;
    } catch (e) {
      print("Weather error: $e");
      return null;
    }
  }
}

