import 'dart:convert';

import 'package:http/http.dart' as http;

class Detail {
  final String glass; //FIELD

  const Detail({required this.glass}); //CONSTRUCTOR

  // FACTORY METHOD fromJSON
  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(glass: json['strGlass']);
  }

  // STATIC FUTURE fetchDetail
  static Future<List<Detail>> fetchDetail(String name) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name'));
    if (response.statusCode == 200) {
      final List<dynamic> detailJson = jsonDecode(response.body)['drinks'];
      return detailJson.map((e) => Detail.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load detail');
    }
  }
}
