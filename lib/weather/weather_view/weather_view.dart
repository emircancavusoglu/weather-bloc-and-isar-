import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/style/text_style.dart';
import 'package:isar_deneme/weather/bloc/weather_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';
import '../../widget/text_field.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.weatherStatus == WeatherStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Hata!"),
            )
            );
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if(state.weatherStatus == WeatherStatus.busy){
            return const Center(
                child: CircularProgressIndicator());
          }
          if(state.weatherStatus == WeatherStatus.fetched) {
            return Center(
              child: buildColumn(state),
            );
          }
          return buildColumn(state);
        }),
      ),
    );
  }

  Container buildColumn(WeatherState state) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightBlue,
                Colors.blue[900]!,
              ]
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const WeatherTextField(),
          if(state.weatherModel != null)...[
            Text(
              state.weatherModel?.location?.name.toString() ?? 'null',
              style: WeatherTextStyle.textStyle,
            ),
            Text(state.weatherModel?.location?.country.toString() ?? ""),
            Text(
              state.weatherModel?.current?.tempC.toString() ?? "null",
              style: WeatherTextStyle.textStyle,
            ),
            Text(
              state.weatherModel?.current?.lastUpdated.toString() ?? "",
              style: WeatherTextStyle.textStyle,
            )
          ]
        ],
      ),
    );
  }
}
