import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mausamie/components/SearchCity.dart';
import 'package:mausamie/providers/Weather_provider.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  TextEditingController cityEditingController = TextEditingController();

  void fetchWeather() {
    ref.read(weatherProvider.notifier).getWeather(cityEditingController.text);
  }

  @override
  
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 234, 255),
      appBar: AppBar(
        title: Text(
          "Mausamie",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchCity(
              controller: cityEditingController,
              onSearch: () {
                fetchWeather();
              },
            ),
            if(weatherState.weather != null)
              Text('resp:${weatherState.weather!.condition.description}'),
            
            
          ],
        ),
      ),
    );
  }
}
