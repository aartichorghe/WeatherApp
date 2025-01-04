
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final double pressure;
  final List<HourlyForecast> hourlyForecast;
  final List<DailyForecast> dailyForecast;

  Weather({
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      hourlyForecast: (json['hourly'] as List)
          .map((data) => HourlyForecast.fromJson(data))
          .toList(),
      dailyForecast: (json['daily'] as List)
          .map((data) => DailyForecast.fromJson(data))
          .toList(),
    );
  }

  @override
  List<Object> get props => [
        temperature,
        description,
        humidity,
        windSpeed,
        pressure,
        hourlyForecast,
        dailyForecast,
      ];
}

class HourlyForecast extends Equatable {
  final String time;
  final double temperature;

  HourlyForecast({required this.time, required this.temperature});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
    );
  }

  @override
  List<Object> get props => [time, temperature];
}

class DailyForecast extends Equatable {
  final String date;
  final double temperature;

  DailyForecast({required this.date, required this.temperature});

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['dt'],
      temperature: json['temp']['day'].toDouble(),
    );
  }

  @override
  List<Object> get props => [date, temperature];
}
