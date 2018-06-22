import 'package:http/http.dart' as http;

/// Creates a new HTTP client.
http.Client newHttpClient() => http.IOClient();
