
import 'package:flutter_riverpod/legacy.dart';
import 'package:mausamie/models/WeatherState.dart';
import 'package:mausamie/services/Weather_Services.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState());

  final WeatherServices _weatherServices = WeatherServices();

  Future<void> getWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Enter city name!',
        weather: null,
      );
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
      );

      final weather =
          await _weatherServices.getWeatherData(cityName.trim());

      state = state.copyWith(
        isLoading: false,
        errorMessage: '',
        weather: weather,
      );
    } catch (e) {
      String error = e.toString().replaceFirst('Exception: ', '');

      state = state.copyWith(
        isLoading: false,
        errorMessage: error,
        weather: null,
      );
    }
  }
}

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);
