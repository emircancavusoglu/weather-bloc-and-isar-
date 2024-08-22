import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import '../weather/bloc/weather_bloc.dart';
import '../weather/service/weather_service.dart';

class WeatherTextField extends StatefulWidget {
  const WeatherTextField({super.key});

  @override
  State<WeatherTextField> createState() => _WeatherTextFieldState();
}

class _WeatherTextFieldState extends State<WeatherTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Enter city name',
      ),
      onSubmitted: (value) async {
        if (value.isNotEmpty) {
          try {
             context.read<WeatherBloc>().add(FetchWeatherInfo(value));
            print("Weather data fetched successfully for $value");
          } catch (e) {
            print("Error fetching weather data: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to fetch weather data for $value')),
            );
          }
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a city name')),
          );
        }
      },
    );
  }
}
