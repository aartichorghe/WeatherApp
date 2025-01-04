
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchWeatherByCity(String city, String apiKey) async {
    try {
      final response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
      return response.data;
    } catch (e) {
      throw Exception("Failed to load weather data");
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByLocation(double latitude, double longitude, String apiKey) async {
    try {
      final response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      return response.data;
    } catch (e) {
      throw Exception("Failed to load weather data");
    }
  }
}
