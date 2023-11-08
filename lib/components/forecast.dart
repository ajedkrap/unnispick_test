import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unnispick_test/constans.dart';
import 'package:unnispick_test/screens/weather_detail_screen.dart';
import 'package:unnispick_test/services/weather.dart';

DateFormat dateFormat = DateFormat('EEE, MMM dd, yyyy h:mm a');


class Forecast extends StatelessWidget {
  Forecast({super.key, required this.weatherData, required this.index});

  final WeatherModel weatherModel = WeatherModel();
  final dynamic weatherData;
  final int index;

  @override
  Widget build(BuildContext context) {
    var timeStamp =
        DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000);

    var weatherIcon = weatherData['weather'][0]['icon'];
    var weatherDate = dateFormat.format(timeStamp);
    var weatherTitle = weatherData['weather'][0]['main'];
    double weatherTemp = weatherData['main']['temp'];

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WeatherDetailScreen(weatherData: weatherData)));
          
        },
        child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                Hero(
                    tag: 'weather-icon',
                    child: SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: weatherModel.getWeatherIcon(weatherIcon))),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weatherDate,
                            style: kPrimaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                        Text(weatherTitle,
                            style: kPrimaryTextStyle.copyWith(fontSize: 16.0)),
                        Text('Temp: ${weatherTemp.toInt()}°C',
                            style: kPrimaryTextStyle),
                      ],
                    ))
              ],
            )));
  }
}