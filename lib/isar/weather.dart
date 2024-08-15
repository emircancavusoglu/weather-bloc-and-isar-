import 'package:isar/isar.dart';

part 'weather.g.dart';

@collection
class City {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? day;

}