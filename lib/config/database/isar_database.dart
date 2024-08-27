import 'package:isar/isar.dart';
import 'package:isar_deneme/config/database/entities/weather.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [WeatherSchema],
      directory: dir.path,
    );
  }
}
