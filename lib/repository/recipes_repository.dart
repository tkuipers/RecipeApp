import 'dart:io';
import 'dart:developer' as developer;

import 'package:recipe_app/dto/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/env_vars.dart';
import 'dart:convert';

import 'package:recipe_app/repository/simple_oauth_client.dart';

class RecipesRepo {
  static final OAuthClient oAuthClient = OAuthClient();
  static Future<List<Recipe>> fetchAllRecipes() async {
    var response = await http.get(
        Uri.parse('${EnvVars.SERVER_ADDRESS}/recipes'),
        headers: Map.fromEntries([await oAuthClient.authHeader]));
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
    var uri = Uri.parse("${EnvVars.SERVER_ADDRESS}/recipes/");
    var request = await client.postUrl(uri);
    request.headers
        .set("Authorization", "Bearer ${await oAuthClient.accessToken}");
    request.followRedirects = true;
    request.write(json.encode(recipe.toJson()));
    var response = await request.close();
    if (response.statusCode == 308) {
      Uri redirectUri =
          Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);
      var output = await getRecipe(int.parse(redirectUri.path.split("/").last));
      return output;
    } else {
      throw Exception('Failed to add recipe ${recipe.recipeUrl}');
    }
  }

  static Future<Recipe> getRecipe(int id) async {
    var response = await http.get(
        Uri.parse('${EnvVars.SERVER_ADDRESS}/recipes/$id'),
        headers: Map.fromEntries([await oAuthClient.authHeader]));
    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get recipe ${id}');
    }
  }

  static Future<void> delete(Recipe r) async {
    var response = await http.delete(
        Uri.parse('${EnvVars.SERVER_ADDRESS}/recipes/${r.id}'),
        headers: Map.fromEntries([await oAuthClient.authHeader]));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe ${r.title}');
    }
  }

  static Future<Recipe> update(Recipe r) async {
    final client = HttpClient();
    var uri = Uri.parse('${EnvVars.SERVER_ADDRESS}/recipes/${r.id}');
    var request = await client.patchUrl(uri);
    request.headers
        .set("Authorization", "Bearer ${await oAuthClient.accessToken}");
    request.headers.contentType = ContentType.json;
    request.followRedirects = true;
    request.write(json.encode(r.toJson()));
    var response = await request.close();
    if (response.statusCode == 200) {
      return r;
    } else {
      throw Exception('Failed to update recipes ${r.title}');
    }
  }
}
