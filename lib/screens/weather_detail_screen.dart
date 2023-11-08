import 'package:flutter/material.dart';
import 'package:unnispick_test/constans.dart';
import 'package:unnispick_test/services/weather.dart';
import 'package:unnispick_test/utils/forecast_detail.dart';

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen(
      {super.key, required this.weatherData, required this.index});

  // final variables
  static String id = 'weather_detail_screen';
  final dynamic weatherData;
  final int index;

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  // states

  WeatherModel weatherModel = WeatherModel();

  // events

  @override
  Widget build(BuildContext context) {
    ForecastDetail forecastDetail =
        ForecastDetail(weatherData: widget.weatherData);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey[800],
            title: Text('Weather Detail',
                style: kPrimaryTextStyle.copyWith(fontWeight: FontWeight.bold)),
            leadingWidth: 36.0,
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 36.0))),
        // floatingactionbutton
        backgroundColor: Colors.blueGrey,
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(forecastDetail.weatherDate,
                        style: kPrimaryTextStyle.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                        )),
                    Text(forecastDetail.weatherHour,
                        style: kPrimaryTextStyle.copyWith(fontSize: 24.0)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${(forecastDetail.weatherTemp).toStringAsFixed(1)}°C',
                        style: kPrimaryTextStyle.copyWith(fontSize: 36.0)),
                    Hero(
                        tag: 'weather-${widget.index}',
                        child: SizedBox(
                          height: 124.0,
                          width: 124.0,
                          child: weatherModel
                              .getWeatherIcon(forecastDetail.weatherIcon),
                        ))
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 36.0),
                    child: Text(
                        '${forecastDetail.weatherTitle} (${forecastDetail.weatherDesc})',
                        style: kPrimaryTextStyle.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Temp (min)',
                            style: kPrimaryTextStyle.copyWith(
                              fontSize: 16.0,
                            )),
                        Text(
                            '${(forecastDetail.weatherTempMin).toStringAsFixed(1)}°C',
                            style: kPrimaryTextStyle.copyWith(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Temp (max)',
                            style: kPrimaryTextStyle.copyWith(
                              fontSize: 16.0,
                            )),
                        Text(
                            '${(forecastDetail.weatherTempMax).toStringAsFixed(1)}°C',
                            style: kPrimaryTextStyle.copyWith(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
