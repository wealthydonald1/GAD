import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TimeService {
  // Free WorldTime API for Lagos/Nigeria
  static const String _apiUrl =
      'http://worldtimeapi.org/api/timezone/Africa/Lagos';

  Future<DateTime> getNetworkTime() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(
            const Duration(seconds: 3),
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DateTime.parse(data['datetime']);
      }
    } catch (e) {
      debugPrint("Network time failed, falling back to system time: $e");
    }
    return DateTime.now();
  }
}
