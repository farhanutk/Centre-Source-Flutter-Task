import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiKey = '32048982-e1b46ee99e28213dd24879a12';

Future getImages(String searchQuery, int page) async {
  final response = await http.get(Uri.parse(
      'https://pixabay.com/api/?key=$apiKey&q=$searchQuery&image_type=photo&page=$page'));

  final Map data = await jsonDecode(response.body);

  final List hits = data["hits"];

  return hits;
}
