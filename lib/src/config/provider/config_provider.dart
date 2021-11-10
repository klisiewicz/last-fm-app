import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiKeyProvider = Provider<String>((Ref ref) {
  const apiKeyVariable = 'API_KEY';
  final apiKey = dotenv.env[apiKeyVariable];
  if (apiKey == null) throw EnvVariableNotFoundError(apiKeyVariable);
  return apiKey;
});

class EnvVariableNotFoundError extends Error {
  final String variable;

  EnvVariableNotFoundError(this.variable);

  @override
  String toString() =>
      'Missing env variable "$variable". Make sure, the the ".env" file exists and contains "$variable" variable.';
}
