import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isar/isar.dart';
import 'package:isar_deneme/config/database/isar_database.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/weather_view/weather_view.dart';
import 'package:path_provider/path_provider.dart';


Future<void> main() async {
  await IsarDatabase.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  Position position = await Geolocator.getCurrentPosition();

  runApp(MyApp(
    position: position,
  ));
}

class MyApp extends StatelessWidget {
  final Position position;

  const MyApp({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => WeatherBloc()..add(FetchWeatherInfoByCoordinates(position.latitude, position.longitude)),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: WeatherView(),
        ),
      ),
    );
  }
}
