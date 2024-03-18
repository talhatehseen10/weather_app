// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

List<City> citiesFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String citiesToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  String? name;
  double? lon;
  double? lat;
  String? country;

  City({
    this.name,
    this.lon,
    this.lat,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lon": lon,
        "lat": lat,
        "country": country,
      };
}
