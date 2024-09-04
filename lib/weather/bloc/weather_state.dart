import 'package:equatable/equatable.dart';
import 'package:isar_deneme/weather/model/weather_model.dart';

enum WeatherStatus { initial, busy, fetched, error, selected }

class WeatherState extends Equatable {
  const WeatherState({
    this.weatherStatus = WeatherStatus.initial,
    this.weatherModel,
    this.errorMessage = '',
    this.cityNames = const [],
  });

  final WeatherStatus weatherStatus;
  final WeatherModel? weatherModel;
  final String errorMessage;
  final List<String> cityNames;

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    WeatherModel? weatherModel,
    String? errorMessage,
    List<String>? cityNames,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weatherModel: weatherModel ?? this.weatherModel,
      errorMessage: errorMessage ?? this.errorMessage,
      cityNames: cityNames ?? this.cityNames,
    );
  }

  @override
  List<Object?> get props => [weatherStatus, weatherModel, errorMessage, cityNames];
}
