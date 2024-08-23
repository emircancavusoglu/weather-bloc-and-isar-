import 'package:equatable/equatable.dart';
import 'package:isar_deneme/weather/model/weather_model.dart';

enum WeatherStatus { initial, busy, fetched, error }

class WeatherState extends Equatable {
   const WeatherState({
    this.weatherStatus = WeatherStatus.initial,
    this.weatherModel,
    this.errorMessage = '',
  });

   final WeatherStatus weatherStatus;
   final WeatherModel? weatherModel;
   final String errorMessage;

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    WeatherModel? weatherModel,
    String? errorMessage,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weatherModel: weatherModel ?? this.weatherModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [weatherStatus, weatherModel, errorMessage];
}
