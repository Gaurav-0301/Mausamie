import 'package:mausamie/models/WeatherModel.dart';

class WeatherState {
  
  final bool isLoading;
  final String errorMessage;
  final WeatherModel? weather;

  WeatherState({
    required this.isLoading,
    required this.errorMessage,
    required this.weather,
  });

  WeatherState copyWith({
  bool? isLoading,
  String? errorMessage,
  WeatherModel? weather,

  })
  {
  return WeatherState(
    isLoading: isLoading ?? this.isLoading, 
    errorMessage: errorMessage ?? this.errorMessage,
     weather: weather ?? this.weather
     );
  }
}
