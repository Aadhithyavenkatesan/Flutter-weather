import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _WeatherService = WeatherService('');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _WeatherService.getCurrentCity();

    //get weather of the city
    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // any catch
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default

    switch (mainCondition.toLowerCase()) {
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/cloudy-rain.json';
      case 'thunderstrom':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //City name
            Text(_weather?.cityName ?? "Loading city.."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}℃'),

            //weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
