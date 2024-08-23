import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/weather_view/weather_view.dart';
import 'location/getLocationPermission.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final String defaultCity = await getLocationCity();
  runApp(MyApp(defaultCity: defaultCity));
}

class MyApp extends StatelessWidget {
  final String defaultCity;
  const MyApp({super.key, required this.defaultCity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => WeatherBloc()..add(FetchWeatherInfo(defaultCity))),
      ],
      child: const MaterialApp(
        home: Scaffold(
            body: WeatherView()),
      ),
    );
  }
}


