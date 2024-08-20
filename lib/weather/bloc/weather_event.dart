
import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {

  @override
  List<Object> get props => [];
}

final class FetchWeatherInfo extends WeatherEvent {
  FetchWeatherInfo(this.filtre);

  final String filtre;
}
