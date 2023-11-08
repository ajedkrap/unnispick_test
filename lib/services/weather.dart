import 'package:flutter/material.dart';
import 'package:unnispick_test/services/location.dart';
import 'package:unnispick_test/services/networking.dart';

const apiKey = '07c23df6c307212052f396910b15426d';
const apiDomain = 'api.openweathermap.org';
const apiRoute = 'data/2.5/forecast';

class WeatherModel {

  // Future<dynamic> getCityWeather(String cityName) async {
  //   var url = Uri.https(apiDomain, apiRoute, {
  //     'q': cityName,
  //     'appid': apiKey,
  //     'units': 'metric',
  //   });

  //   NetworkHelper networkHelper = NetworkHelper(url);
  //   var weatherData = await networkHelper.getData();
  //   return weatherData;

  // }


  Future<dynamic> getLocationForecast() async {

    Location location = Location();

    await location.getCurrentLocation();

    var url = Uri.https(apiDomain, apiRoute, {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': apiKey,
      'units': 'metric',
    });

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData['list'];
  }

  Image getWeatherIcon(String iconId) {
    return Image.network('https://openweathermap.org/img/wn/$iconId@2x.png');
  }

}
