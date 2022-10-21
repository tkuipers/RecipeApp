import 'dart:io';
import 'dart:developer' as developer;

import 'package:recipe_app/dto/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesRepo {
  static Future<List<Recipe>> fetchAllRecipes() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:8000/recipes'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Recipe> recipes =
          List<Recipe>.from(l.map((model) => Recipe.fromJson(model)));
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<Recipe> add(NewRecipeDTO recipe) async {
    final client = HttpClient();
    var uri = Uri.parse("http://127.0.0.1:8000/recipes/");
    var request = await client.postUrl(uri);
    request.followRedirects = true;
    request.write(json.encode(recipe.toJson()));
    var response = await request.close();
    if (response.statusCode == 308) {
      Uri redirectUri =
          Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);
      var output = await getRecipe(int.parse(redirectUri.path.split("/").last));
      return output;
    } else {
      throw Exception('Failed to add recipes');
    }
  }

  static Future<Recipe> getRecipe(int id) async {
    var response =
        await http.get(Uri.parse('http://127.0.0.1:8000/recipes/$id'));
    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<void> delete(Recipe r) async {
    var response =
        await http.delete(Uri.parse('http://127.0.0.1:8000/recipes/${r.id}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<Recipe> update(Recipe r) async {
    var response = await http.patch(
        Uri.parse('http://127.0.0.1:8000/recipes/${r.id}'),
        body: r.toJson());
    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
