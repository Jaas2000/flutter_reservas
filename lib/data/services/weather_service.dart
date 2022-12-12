import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  getData(courtId) async {
    Uri fullUrl = Uri.parse('');

    if (courtId == "1") {
      fullUrl = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${dotenv.get('PANAMALAT')}&lon=${dotenv.get('PANAMALNG')}&appid=${dotenv.get('KEY')}");
    } else if (courtId == "2") {
      fullUrl = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${dotenv.get('INDIALAT')}&lon=${dotenv.get('INDIALNG')}&appid=${dotenv.get('KEY')}");
    } else if (courtId == "3") {
      fullUrl = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${dotenv.get('ESPANALAT')}&lon=${dotenv.get('ESPANALNG')}&appid=${dotenv.get('KEY')}");
    }
    final response = await http.get(fullUrl);
    return await jsonDecode(response.body);
  }
}
