
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mausamie/components/SearchCity.dart';
import 'package:mausamie/components/RotatingEarth.dart';
import 'package:mausamie/components/WeatherInfoCard.dart';
import 'package:mausamie/components/WeatherDetails.dart';
import 'package:mausamie/providers/Weather_provider.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() =>
      _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController cityEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCurrentLocationWeather();
    });
  }

  void fetchWeather() {
    final city = cityEditingController.text.trim();

    FocusScope.of(context).unfocus();
    ref.read(weatherProvider.notifier).getWeather(city);
  }

  void fetchCurrentLocationWeather() {
    cityEditingController.clear();
    FocusScope.of(context).unfocus();
    ref.read(weatherProvider.notifier).fetchCurrentLocationWeather();
  }

  @override
  void dispose() {
    cityEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);
    final weather = weatherState.weather;

    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final isTablet = screenWidth >= 600;
    final horizontalPadding = isTablet ? 32.0 : 20.0;

    final earthSize =
        (screenWidth * 0.90).clamp(260.0, 480.0);

    final contentTopPadding =
        (screenHeight * 0.32).clamp(210.0, 300.0);

    return Scaffold(
      backgroundColor: const Color(0xFF041225),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF123D70),
                    Color(0xFF06284C),
                    Color(0xFF020B18),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.28,
            left: 0,
            right: 0,
            child: Center(
              child: IgnorePointer(
                child: Container(
                  width: earthSize,
                  height: earthSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF168BFF)
                            .withValues(alpha: 0.15),
                        blurRadius: isTablet ? 65 : 45,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const RotatingEarth(),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    16,
                    horizontalPadding,
                    12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.public_rounded,
                            color: Color(0xFF91D7FF),
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Mausamie',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.wb_twilight_rounded,
                            color: Color(0xFFFFD166),
                            size: 27,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your little window to the sky.',
                        style: TextStyle(
                          color: Color(0xFFADC5DF),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: screenHeight < 700 ? 14 : 22),
                      SearchCity(
                        controller: cityEditingController,
                        onSearch: fetchWeather,
                        onCurrentLocation: fetchCurrentLocationWeather,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final topPadding = contentTopPadding
                          .clamp(0.0, constraints.maxHeight * 0.65);

                      return SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          topPadding,
                          horizontalPadding,
                          24,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isTablet ? 700 : 500,
                            ),
                            child: Builder(
                              builder: (context) {
                                if (weatherState.isLoading) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(
                                            color: Color(0xFF91D7FF),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Fetching weather...',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (weatherState.errorMessage.isNotEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF172A40)
                                          .withValues(alpha: 0.95),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.redAccent
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.location_off_rounded,
                                          color: Colors.redAccent,
                                          size: 38,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Oops! Weather not found',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          weatherState.errorMessage,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFFADC5DF),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            TextButton.icon(
                                              onPressed: fetchCurrentLocationWeather,
                                              icon: const Icon(
                                                Icons.my_location_rounded,
                                                size: 18,
                                              ),
                                              label: const Text('Use Current Location'),
                                            ),
                                            if (cityEditingController.text.trim().isNotEmpty)
                                              TextButton.icon(
                                                onPressed: fetchWeather,
                                                icon: const Icon(
                                                  Icons.refresh,
                                                  size: 18,
                                                ),
                                                label: const Text('Retry Search'),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }

                              

if (weather == null) {
  return Padding(
    padding: EdgeInsets.only(
      top: (screenHeight * 0.15).clamp(30.0, 100.0),
    ),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.cloud_outlined,
            size: screenWidth < 360 ? 45 : 55,
            color: const Color(0xFF91D7FF),
          ),
          const SizedBox(height: 16),
          Text(
            'Discover the Weather',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth < 360 ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Search a city or use your current location.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFADC5DF),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: fetchCurrentLocationWeather,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF168BFF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.my_location_rounded, size: 18),
            label: const Text('Detect Current Location'),
          ),
        ],
      ),
    ),
  );
}



                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    WeatherInfoCard(weather: weather),
                                    const SizedBox(height: 22),
                                    const Text(
                                      'Weather at a glance',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    WeatherDetails(weather: weather),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
