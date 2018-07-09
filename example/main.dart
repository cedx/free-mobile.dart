import 'dart:async';
import 'package:free_mobile/free_mobile.dart';

/// Sends an SMS notification.
Future<void> main() async {
  try {
    var client = Client('your account identifier', 'your API key');
    // For example: Client('12345678', 'a9BkVohJun4MAf')

    await client.sendMessage('Hello World!');
    print('The message was sent successfully');
  }

  on ClientException catch (err) {
    print('An error occurred: ${err.message}');
    print('From: ${err.uri}');
  }
}
