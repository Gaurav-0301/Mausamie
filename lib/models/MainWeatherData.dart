
class MainWeatherData {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int humidity;

  MainWeatherData({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
  });

  MainWeatherData.fromJson(Map<String, dynamic> json)
      : temp = (json['main']['temp'] as num).toDouble(),
        feels_like = (json['main']['feels_like'] as num).toDouble(),
        temp_min = (json['main']['temp_min'] as num).toDouble(),
        temp_max = (json['main']['temp_max'] as num).toDouble(),
        pressure = (json['main']['pressure'] as num).toInt(),
        humidity = (json['main']['humidity'] as num).toInt();
}

