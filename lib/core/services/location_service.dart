import 'package:geolocator/geolocator.dart';

class LocationService {
  // Office coordinates (example)
  static const double officeLat = 9.0579;
  static const double officeLng = 7.4951;

  static const double allowedRadius = 150; // meters

  Future<bool> isWithinOfficeRadius() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied forever');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final distance = Geolocator.distanceBetween(
      officeLat,
      officeLng,
      position.latitude,
      position.longitude,
    );

    return distance <= allowedRadius;
  }
}
