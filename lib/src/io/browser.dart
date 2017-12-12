import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';

/// Creates a new HTTP client.
http.Client newHttpClient() => new BrowserClient();
