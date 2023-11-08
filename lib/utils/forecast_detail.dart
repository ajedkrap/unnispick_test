import 'package:intl/intl.dart';

DateFormat dateFormat2 = DateFormat('EEE, MMM dd, yyyy h:mm a');
DateFormat dateFormat = DateFormat('EEEE, MMMM dd, yyyy');
DateFormat hourFormat = DateFormat('h:mm a');

class ForecastDetail {
  String weatherDate = '';
  String weatherDate2 = '';
  String weatherHour = '';
  String weatherTitle = '';
  String weatherDesc = '';
  String weatherIcon = '10d';
  double weatherTemp = 0.0;
  double weatherTempMin = 0.0;
  double weatherTempMax = 0.0;

  ForecastDetail({
    dynamic weatherData,
  }) {
    var timeStamp = weatherData['dt'] != null
        ? DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000)
        : DateTime.now();

    weatherDate = dateFormat.format(timeStamp);
    weatherDate2 = dateFormat2.format(timeStamp);
    weatherHour = hourFormat.format(timeStamp);
    weatherTitle = weatherData['weather'][0]['main'] ?? 'error';
    weatherDesc = weatherData['weather'][0]['description'] ?? '';
    weatherIcon = weatherData['weather'][0]['icon'] ?? '10d';
    weatherTemp = double.parse((weatherData['main']['temp'] ?? 0.0).toString());
    weatherTempMin = double.parse((weatherData['main']['temp_min'] ?? 0.0).toString());
    weatherTempMax = double.parse((weatherData['main']['temp_max'] ?? 0.0).toString());
  }
}