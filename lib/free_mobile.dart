/// Send SMS messages to your [Free Mobile](http://mobile.free.fr) account.
library free_mobile;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'src/client.dart';

/// Sends a SMS message to a given Free Mobile account, and returns the response body.
Future<String> sendMessage(String text, {@required String username, @required String password}) async
  => new Client(username, password).sendMessage(text);
