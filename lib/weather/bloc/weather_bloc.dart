import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_deneme/weather/bloc/weather_event.dart';
import 'package:isar_deneme/weather/bloc/weather_state.dart';
import 'package:isar_deneme/weather/service/weather_service.dart';

import '../model/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherState()) {

    on<FetchWeatherInfo>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.busy));
      try {
        final weatherModel = await WeatherService.fetchData(event.filter);
        emit(state.copyWith(
          weatherStatus: WeatherStatus.fetched,
          weatherModel: weatherModel,
        ));
      } catch (e) {
        emit(state.copyWith(
            weatherStatus: WeatherStatus.error,
            errorMessage: e.toString()));
      }
    });

    on<FetchWeatherInfoByCoordinates>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.busy));
      try {
        final weatherModel = await WeatherService.fetchDataByCoordinates(event.latitude, event.longitude);
        emit(state.copyWith(
          weatherStatus: WeatherStatus.fetched,
          weatherModel: weatherModel,
        ));
      } catch (e) {
        emit(state.copyWith(
            weatherStatus: WeatherStatus.error,
            errorMessage: e.toString()));
      }
    });

    on<WeatherDataSelectedEvent>((event, emit) {
      emit(state.copyWith(
          weatherModel: WeatherModel(
              location: Location(name: event.location),
              current: Current(tempC: event.temperature)
          ),
          weatherStatus: WeatherStatus.selected
      ));
    });
  }
}
