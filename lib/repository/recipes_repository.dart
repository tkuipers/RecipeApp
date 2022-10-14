import 'dart:io';
import 'dart:developer' as developer;

import 'package:recipe_app/dto/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesRepo {
  static Future<List<Recipe>> fetchAllRecipes() async {
    var response =
        await http.get(Uri.parse('http://192.168.178.146:8000/recipes'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable l = json.decode(response.body);
      List<Recipe> recipes =
          List<Recipe>.from(l.map((model) => Recipe.fromJson(model)));
      developer.log('log me', name: 'my.app.category');
      return recipes;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load recipes');
    }
  }
}
