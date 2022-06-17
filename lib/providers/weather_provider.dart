import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/models/prev_city_weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final String _apiKey = '71e5596795094ed1894144504221506';
  final String _baseUrl = 'api.weatherapi.com';
  final String _lang = 'es';
  final String _days = '5';

  CityWeatherModel? currentCityWeather;
  List<Forecastday> prevCityWeatherModel = [];

  final StreamController<CityWeatherModel> _suggestionStreamController =
      StreamController.broadcast();

  Stream<CityWeatherModel> get suggestionsStream =>
      _suggestionStreamController.stream;

  WeatherProvider() {}

  Future<String> _getJsonData(String endpoint, String query) async {
    // Await the http get response, then decode the json-formatted response.

    try {
      final url = Uri.https(
          _baseUrl, endpoint, {'key': _apiKey, 'q': query, 'lang': _lang});
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      return Future.error('La ciudad introducida no es válida');
    }
  }

  Future<String> _getJsonDataDays(String endpoint, String query) async {
    try {
      final url = Uri.https(_baseUrl, endpoint,
          {'key': _apiKey, 'q': query, 'lang': _lang, 'days': _days});
      final response = await http.get(url);

      return response.body;
    } catch (e) {
      return Future.error('La ciudad introducida no es válida');
    }

    // Await the http get response, then decode the json-formatted response.
  }

  Future<CityWeatherModel> getCurrentCityWeather(String query) async {

    final jsonData = await _getJsonData('v1/current.json', query);

    final cityWeatherResponse = CityWeatherModel.fromJson(jsonData);

    currentCityWeather = cityWeatherResponse;

    String temp = currentCityWeather!.current.tempC.toString();

    print(temp);

    notifyListeners();

    return cityWeatherResponse;
  }

  getPrevisionCityWeather(String query) async {
    final jsonData = await _getJsonDataDays('v1/forecast.json', query);

    final prevWeatherResponse =
        PrevCityWeatherModel.fromJson(jsonData).forecast.forecastday;

    prevCityWeatherModel = prevWeatherResponse;

    notifyListeners();
  }
}
