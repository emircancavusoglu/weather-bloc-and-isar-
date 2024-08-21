import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/weather_view/weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => WeatherBloc()..add(FetchWeatherInfo("Bursa"))),
      ],
      child: const MaterialApp(
        home: Scaffold(
            body: WeatherView()),
      ),
    );
  }
}


