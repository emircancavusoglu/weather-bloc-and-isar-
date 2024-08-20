import 'package:isar/isar.dart';
import 'package:isar_deneme/isar/weather.dart';
import 'package:path_provider/path_provider.dart';

class WeatherDatabase {
  //initialize, create, read, update, delete

  static late Isar isar;

  static Future<void> initialize()async{
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [CitySchema],
      directory: dir.path,
    );
  }
  final List<City>currentCity = [];


}