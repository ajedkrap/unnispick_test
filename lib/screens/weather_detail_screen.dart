import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat('EEEE, MMMM dd, yyyy');
DateFormat hourFormat = DateFormat('h:mm a');

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({super.key, required this.weatherData});

  // final variables
  static String id = 'weather_detail_screen';
  final dynamic weatherData;

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  // states

  // events

  @override
  Widget build(BuildContext context) {
    var weather = widget.weatherData;

    return Scaffold(
        appBar: AppBar(
            title: const Text('Weather Detail'),
            leadingWidth: 50.0,
            leading: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 48.0))),
        // floatingactionbutton
        backgroundColor: Colors.blueGrey,
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
            child: const Column(
              children: [
                Column(),
                Row(),
                Column(),
                Row(),
              ],
            )));
  }
}
