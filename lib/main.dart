import 'package:flutter/material.dart';
import 'package:flutter_app/state_management/weather_bloc.dart';
import 'package:flutter_app/ui/forecast_page.dart';
import 'package:flutter_app/ui/weather_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyAssignmentApp());
}

class MyAssignmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<WeatherBloc>(
          create: (BuildContext context) => WeatherBloc(),
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => WeatherPage(),
              '/forecast': (context) => ForecastPage(),
            },
          ),
        );
      },
    );
  }
}
