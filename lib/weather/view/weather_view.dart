import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/style/text_style.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.weatherStatus == WeatherStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if(state.weatherStatus == WeatherStatus.fetched) {
          return Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              title: Center(
                  child: Text(
                    "Yerel Saat: ${state.weatherModel.local.localtime}",
                    style: WeatherTextStyle.textStyle,
                  )),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.weatherModel.local.name ?? 'null',
                  style: WeatherTextStyle.textStyle,
                ),
                Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 80,
                      ),
                      Text('icon data: ${state.weatherModel.current.icon}')
                    ],
                  ),
                ),
                Text(
                  state.weatherModel.current.tempC.toString(),
                  style: WeatherTextStyle.textStyle,
                ),
                Text(
                  state.weatherModel.current.icon.toString(),
                  style: WeatherTextStyle.textStyle,
                ),
                Text(
                  state.weatherModel.current.lastUpdated.toString(),
                  style: WeatherTextStyle.textStyle,
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
