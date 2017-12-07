/// Send SMS messages to your [Free Mobile](http://mobile.free.fr) account.
library free_mobile;

import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'io.dart'
  if (dart.library.html) 'src/io/browser.dart'
  if (dart.library.io) 'src/io/vm.dart';

part 'src/client.dart';
