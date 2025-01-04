import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String selectedCity;
  final List<String> cities;

  const WeatherLoaded({required this.selectedCity, required this.cities});

  @override
  List<Object?> get props => [selectedCity, cities];
}

class WeatherError extends WeatherState {
  final String error;

  const WeatherError({required this.error});

  @override
  List<Object?> get props => [error];
}
