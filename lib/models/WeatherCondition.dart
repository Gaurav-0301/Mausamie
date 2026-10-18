// ignore: file_names
class WeatherCondition {
  final String main;
  final String description;
  WeatherCondition({required this.main, required this.description});
  WeatherCondition.fromJson(Map<String, dynamic> json)
    : main = json['weather']['main'].toString(),
      description = json['weather']['description'].toString();
}
