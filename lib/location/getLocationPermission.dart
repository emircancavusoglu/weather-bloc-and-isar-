import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<bool> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }
  }
  return permission != LocationPermission.deniedForever;
}

Future<String> getCityFromCoordinates(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return place.locality ?? "Hata: Şehir adı bulunamadı";
    } else {
      return "Hata: Şehir adı bulunamadı";
    }
  } catch (e) {
    print("Hata: $e");
    return "Hata: $e";
  }
}