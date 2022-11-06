import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipe_app/env_vars.dart';

class OAuthClient {
  String? _accessToken;

  Future<String> get accessToken async {
    var response = await http.get(
        Uri.parse('${EnvVars.SERVER_ADDRESS}/recipes'),
        headers: {"Authorization": "Bearer ${_accessToken ?? ''}"});
    if (response.statusCode != 200) {
      _accessToken ??= await refreshAccessToken();
    }
    return _accessToken!;
  }

  Future<MapEntry<String, String>> get authHeader async {
    return MapEntry("Authorization", "Bearer ${await accessToken}");
  }

  Future<String> refreshAccessToken() async {
    var uri = Uri.parse("${EnvVars.SERVER_ADDRESS}/token");
    var response = await http.post(uri, body: {
      "username": EnvVars.SERVER_USERNAME,
      "password": EnvVars.SERVER_PASSWORD
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)['access_token'];
    } else {
      throw Exception('Failed to get oauth token');
    }
  }
}
