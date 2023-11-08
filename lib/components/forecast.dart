import 'package:flutter/material.dart';
import 'package:unnispick_test/constans.dart';
import 'package:unnispick_test/screens/weather_detail_screen.dart';
import 'package:unnispick_test/services/weather.dart';
import 'package:unnispick_test/utils/forecast_detail.dart';

class Forecast extends StatelessWidget {
  Forecast({super.key, required this.weatherData, required this.index});

  final WeatherModel weatherModel = WeatherModel();
  final dynamic weatherData;
  final int index;

  @override
  Widget build(BuildContext context) {

    ForecastDetail forecastDetail = ForecastDetail(weatherData: weatherData);

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WeatherDetailScreen(
                      weatherData: weatherData, index: index)));
        },
        child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                Hero(
                    tag: 'weather-$index',
                    child: SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: weatherModel.getWeatherIcon(forecastDetail.weatherIcon))),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(forecastDetail.weatherDate2,
                            style: kPrimaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                        Text(forecastDetail.weatherTitle,
                            style: kPrimaryTextStyle.copyWith(fontSize: 16.0)),
                        Text('Temp: ${forecastDetail.weatherTemp}°C',
                            style: kPrimaryTextStyle),
                      ],
                    ))
              ],
            )));
  }
}
