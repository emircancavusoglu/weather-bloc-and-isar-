import 'package:hive/hive.dart';

part 'weather_hive_model.g.dart';

@HiveType(typeId: 0)
class WeatherHiveModel extends HiveObject {
  @HiveField(0)
  final String location;

  @HiveField(1)
  final String condition;

  @HiveField(2)
  final double temperature;

  WeatherHiveModel({required this.location, required this.condition, required this.temperature});

  factory WeatherHiveModel.fromJson(Map<String, dynamic> json) {
    return WeatherHiveModel(
      location: json['location']['name'] as String,
      condition: json['current']['condition']['text'] as String,
      temperature: (json['current']['temp_c'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'condition': condition,
      'temperature': temperature,
    };
  }
}
