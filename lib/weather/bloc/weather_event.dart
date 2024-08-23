
import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {

  @override
  List<Object> get props => [];
}

final class FetchWeatherInfo extends WeatherEvent {
  FetchWeatherInfo(this.filter);

  final String filter;
}
final class TakeFormat extends WeatherEvent{

}
class FetchWeatherInfoByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;
  FetchWeatherInfoByCoordinates(this.latitude, this.longitude);
}
