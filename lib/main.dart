import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/model/weather_hive_model.dart';
import 'package:isar_deneme/weather/weather_view/weather_view.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherHiveModelAdapter());

  var textFieldBox = await Hive.openBox("textField box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: Geolocator.getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else {
          final position = snapshot.data!;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (c) => WeatherBloc()
                  ..add(FetchWeatherInfoByCoordinates(
                    position.latitude,
                    position.longitude,
                  )),
              ),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: WeatherView(),
              ),
            ),
          );
        }
      },
    );
  }
}
