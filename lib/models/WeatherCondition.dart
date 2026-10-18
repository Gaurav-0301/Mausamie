// ignore: file_names
class WeatherCondition {
  final String main;
  final String description;
  WeatherCondition({required this.main, required this.description});
  WeatherCondition.fromJson(Map<String, dynamic> json)
    : main = json['weather'][0]['main'].toString(),
      description = json['weather'][0]['description'].toString();
}
