import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(var latitude,var longitude) async{
    var uricall = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=17ef142b20dbd3615549dec5b7e01e77');
    var response = await http.get(uricall);
    var body = jsonDecode(response.body);
    return WeatherModel.fromJson(body);
  }

}
