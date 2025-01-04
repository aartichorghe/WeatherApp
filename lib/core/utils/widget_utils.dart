import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherIconWithTitle extends StatelessWidget {
  final IconData icon;
  final String header;
  final Color color;

  const WeatherIconWithTitle(
      {super.key,
      required this.icon,
      required this.header,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30.sp, color: color),
          SizedBox(height: 10.h),
          Text(header, style: AppStyles.iconHeaderStyle),
        ],
      ),
    );
  }
}
