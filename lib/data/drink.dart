import 'dart:convert';

import 'package:http/http.dart' as http;

class Drink {
  final String id;
  final String name;
  final String thumb;

  const Drink({required this.id, required this.name, required this.thumb});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
        name: json['strDrink'],
        id: json['idDrink'],
        thumb: json['strDrinkThumb']);
  }

  static Future<List<Drink>> fetchDrink() async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'));

    if (response.statusCode == 200) {
      final List<dynamic> cocktailJson = jsonDecode(response.body)['drinks'];
      return cocktailJson.map((e) => Drink.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load drink');
    }
  }
}
