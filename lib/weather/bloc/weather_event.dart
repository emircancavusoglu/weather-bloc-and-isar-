import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeatherInfo extends WeatherEvent {
  final String filter;

  FetchWeatherInfo(this.filter);

  @override
  List<Object> get props => [filter];
}

class FetchWeatherInfoByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchWeatherInfoByCoordinates(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}
class WeatherDataSelectedEvent extends WeatherEvent {
  final String location;
  final double temperature;

  WeatherDataSelectedEvent({
    required this.location,
    required this.temperature,
  });

  @override
  List<Object> get props => [location, temperature];
}
