import 'package:isar/isar.dart';

part 'weather.g.dart';

@collection
class Weather {
  Id id = Isar.autoIncrement;
  late String cityName;
  late String country;
  late String temperature;
  late String iconUrl;
  DateTime dateTime = DateTime.now();
}