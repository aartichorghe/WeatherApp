import 'package:equatable/equatable.dart';

// Define an abstract class for weather events
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

// Event to load weather data (this can trigger the location fetch)
class LoadWeatherData extends WeatherEvent {}

// Event to select a city
class SelectCity extends WeatherEvent {
  final String city;

  const SelectCity(this.city);

  @override
  List<Object?> get props => [city];
}
