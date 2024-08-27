import 'package:flutter/cupertino.dart';
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
    return Align(
      alignment: Alignment.center, // Center alignment
      child: SizedBox(
        width: 290, // Adjust the width as needed
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
              },
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter city name',
          ),
          onSubmitted: (value) async {
            if (value.isNotEmpty) {
              context.read<WeatherBloc>().add(FetchWeatherInfo(value));
              print("Weather data fetched successfully for $value");
              _controller.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a city name')),
              );
            }
          },
        ),
      ),
    );
  }
}
