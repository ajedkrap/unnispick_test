import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:unnispick_test/components/forecast.dart';
import 'package:unnispick_test/screens/login_screen.dart';
import 'package:unnispick_test/services/weather.dart';
import 'package:unnispick_test/constans.dart';


class WeathersScreen extends StatefulWidget {
  const WeathersScreen({super.key});

  // final variables
  static String id = 'weathers_screen';

  @override
  State<WeathersScreen> createState() => _WeathersScreenState();
}

class _WeathersScreenState extends State<WeathersScreen> {
  // states
  final _auth = FirebaseAuth.instance;
  bool isLoading = true;
  List<dynamic> weatherData = [];
  WeatherModel weather = WeatherModel();

  // events

  void onSignOut() async {
    Navigator.pushNamed(context, LoginScreen.id);
  }

  void getForecast() async {
    try {
      var forecasts = await weather.getLocationForecast();
      setState(() {
        weatherData = forecasts;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weathers',
              style: kPrimaryTextStyle.copyWith(
                  fontSize: 24.0, fontWeight: FontWeight.w700)),
          // leadingWidth: screenWidth / 4.5,
          leading: InkWell(
              onTap: () async {
                await _auth.signOut();
                onSignOut();
              },
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 36.0,
              )),
          backgroundColor: Colors.blueGrey[700],
        ),
        // floatingactionbutton
        backgroundColor: Colors.blueGrey,
        body: Container(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : ListView.separated(
                  itemCount: weatherData.length,
                  separatorBuilder: (context, _) => Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.white70),
                  itemBuilder: (context, idx) =>
                      Forecast(weatherData: weatherData[idx], index: idx)),
        ));
  }
}


