import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import '../weather/bloc/weather_bloc.dart';

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
        border: OutlineInputBorder(),
        hintText: 'Enter city name',
      ),
      onSubmitted: (value) async {
        if (value.isNotEmpty) {
          context.read<WeatherBloc>().add(FetchWeatherInfo(value));
            print("Weather data fetched successfully for $value");
            _controller.clear();
            print("Error fetching weather data:");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a city name')),
          );
        }
      },
    );
  }
}
