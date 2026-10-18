import 'package:flutter_riverpod/legacy.dart';
import 'package:mausamie/models/WeatherState.dart';
import 'package:mausamie/services/Weather_Services.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState());
  WeatherServices _weatherServices = WeatherServices();

  Future<void> getWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Enter city Name !!', weather: null);
      return;
    }
    try {
      state = state.copyWith(isLoading: true, errorMessage: '', weather: null);
      final weather = await _weatherServices.getWeatherData(cityName);

      state = state.copyWith(
        isLoading: false,
        errorMessage: '',
        weather: weather,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        weather: null,
      );
      return;
    }
  }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);
