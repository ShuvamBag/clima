import 'package:flutter/foundation.dart';

class WeatherModel{
  var CityName;
  var temp;
  var humidity;
  var windspeed;
  var pressure;

  WeatherModel({required this.CityName,required this.temp, required this.humidity,required this.windspeed,required this.pressure} );
  WeatherModel.fromJson(Map<String, dynamic> json){
    CityName = json["name"];
    temp = json["main"]["temp"];
    humidity = json["main"]["humidity"];
    windspeed = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
  }
}