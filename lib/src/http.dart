/// Provides the HTTP client.
library free_mobile.http;

import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'io.dart'
  if (dart.library.html) 'io/browser.dart'
  if (dart.library.io) 'io/vm.dart';

part 'http/client.dart';
