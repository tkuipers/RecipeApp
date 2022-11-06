import 'dart:io';

class EnvVars {
  static final Map<String, String> envVars = Platform.environment;
  static const String SERVER_ADDRESS = String.fromEnvironment('SERVER_ADDRESS');
  static const String SERVER_USERNAME =
      String.fromEnvironment('SERVER_USERNAME');
  static const String SERVER_PASSWORD =
      String.fromEnvironment('SERVER_PASSWORD');
}
