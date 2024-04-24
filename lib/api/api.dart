import 'dart:convert';

import 'package:projeto_tempo/constants/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_tempo/models/api_model.dart';

class WeatherApi {
  // 'http://api.weatherapi.com/v1/current.json/current.json?Key=5edfd9657e2f41bca38224720242204&q=aracaju';
  final String baseUrl =
      'http://api.weatherapi.com/v1/current.json/current.json';

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl =
        'http://api.weatherapi.com/v1/current.json/current.json?Key=$apiKey&q=$location';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Error ${e.toString()}');
    }
  }
}
