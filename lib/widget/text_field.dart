import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import '../weather/bloc/weather_bloc.dart';

class WeatherTextField extends StatefulWidget {
  final TextEditingController controller;

  const WeatherTextField({super.key, required this.controller});

  @override
  State<WeatherTextField> createState() => WeatherTextFieldState();
}

class WeatherTextFieldState extends State<WeatherTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  String get currentText => widget.controller.text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 290,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                widget.controller.clear();
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
              widget.controller.clear();
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
