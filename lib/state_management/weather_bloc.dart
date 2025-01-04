import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    // Handling the LoadWeatherData event
    on<LoadWeatherData>(_onLoadWeatherData);
    
    // Handling the SelectCity event
    on<SelectCity>(_onSelectCity);
  }

  final List<String> availableCities = [
    'Mumbai',
    'Pune',
    'Delhi',
    'Bangalore',
    'Chennai',
    'Kolkata'
  ];

  // Method to handle LoadWeatherData event
  Future<void> _onLoadWeatherData(
    LoadWeatherData event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final location = Location();
      
      // Check if location service is enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception('Location services disabled');
        }
      }

      // Check if permission is granted for accessing location
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception('Location permission denied');
        }
      }

      // Fetch the current location
      final locationData = await location.getLocation();

      // Determine the city based on latitude and longitude (you can modify this logic)
      final String defaultCity = determineCityFromLatLong(
          locationData.latitude!, locationData.longitude!);

      // Emit the loaded state with the fetched city and available cities
      emit(WeatherLoaded(selectedCity: defaultCity, cities: availableCities));
    } catch (e) {
      // In case of any error, emit the error state
      emit(WeatherError(error: e.toString()));
    }
  }

  // Method to handle SelectCity event
  void _onSelectCity(
    SelectCity event,
    Emitter<WeatherState> emit,
  ) {
    if (state is WeatherLoaded) {
      emit(WeatherLoaded(
          selectedCity: event.city, cities: availableCities));
    }
  }

  // This is a placeholder method that could be expanded to convert lat/long to a city name
  String determineCityFromLatLong(double lat, double lon) {
    // Placeholder logic: you can replace this with an API or some other mechanism to determine the city
    return availableCities.first; // For simplicity, just return the first city in the list
  }
}
