import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_styles.dart';
import 'package:flutter_app/core/utils/widget_utils.dart';
import 'package:flutter_app/state_management/weather_bloc.dart';
import 'package:flutter_app/state_management/weather_event.dart';
import 'package:flutter_app/state_management/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? selectedCity;
  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix'
  ];

  @override
  void initState() {
    super.initState();
    // Dispatch the LoadWeatherData event to fetch initial weather data
    context.read<WeatherBloc>().add(LoadWeatherData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.sp),
              height: 500.h,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0047AB).withOpacity(0.8),
                        Color(0xFF007FFF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.scale(
                              scaleX: -1,
                              child: Icon(
                                Icons.brightness_2,
                                color: Colors.white,
                              ),
                            ),

                            BlocBuilder<WeatherBloc, WeatherState>(
                              builder: (context, state) {
                                if (state is WeatherLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (state is WeatherError) {
                                  return Center(child: Text(state.error));
                                } else if (state is WeatherLoaded) {
                                  return SafeArea(
                                    child: Scaffold(
                                      body: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            height: 500,
                                            child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF0047AB)
                                                          .withOpacity(0.8),
                                                      Color(0xFF007FFF),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Transform.scale(
                                                            scaleX: -1,
                                                            child: Icon(
                                                              Icons
                                                                  .brightness_2,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          DropdownButton<
                                                              String>(
                                                            value: state
                                                                .selectedCity,
                                                            hint: Text(
                                                                "Select City",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            dropdownColor:
                                                                Colors.blue,
                                                            items: state.cities.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                city) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: city,
                                                                child: Text(
                                                                    city,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              if (newValue !=
                                                                  null) {
                                                                context
                                                                    .read<
                                                                        WeatherBloc>()
                                                                    .add(SelectCity(
                                                                        newValue));
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Rest of the weather UI
                                                    Image.asset(
                                                        'assets/images/ic_weather.png',
                                                        height: 180,
                                                        width: 300),
                                                    Text(
                                                      '29\u00B0',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Text('Overcast',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(child: Text('Unknown state'));
                                }
                              },
                            )

                            // DropdownButton<String>(
                            //   value: selectedCity,
                            //   hint: Text("Select City",
                            //       style: TextStyle(color: Colors.white)),
                            //   dropdownColor: Colors
                            //       .blue, // Match dropdown with card background
                            //   items: cities
                            //       .map<DropdownMenuItem<String>>((String city) {
                            //     return DropdownMenuItem<String>(
                            //       value: city,
                            //       child: Text(city,
                            //           style: TextStyle(color: Colors.white)),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       selectedCity = newValue;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/ic_weather.png',
                          height: 180.h, width: 300.w),
                      Text(
                        '29\u00B0',
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15.h),
                      Text('Overcast', style: AppStyles.mainDataStyle),
                      SizedBox(height: 10.h),
                      Text('Monday, February 27',
                          style: AppStyles.mainDataStyle),
                      SizedBox(height: 10.h),
                      Divider(
                        indent: 35.sp,
                        endIndent: 35.sp,
                        color: Colors.grey,
                        thickness: 1.2,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WeatherIconWithTitle(
                              icon: Icons.air,
                              header: '6km/h',
                              color: Colors.green),
                          WeatherIconWithTitle(
                              icon: Icons.water_drop,
                              header: '31%',
                              color: Colors.white),
                          WeatherIconWithTitle(
                              icon: Icons.cloud,
                              header: '0%',
                              color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today', style: AppStyles.dayTitleStyle),
                  Text('Forecasts', style: AppStyles.forecastTitleStyle)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        height: 120.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50.0.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('44:44', style: AppStyles.mainDataStyle),
                            Icon(Icons.abc),
                            Text('15', style: AppStyles.mainDataStyle),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
