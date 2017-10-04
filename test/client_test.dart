import 'dart:io';
import 'package:free_mobile/free_mobile.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('.sendMessage()', () {
    test('should not send valid messages with invalid credentials', () {
      expect(new Client('', '').sendMessage('Hello World!'), throwsArgumentError);
    });

    test('should not send invalid messages with valid credentials', () {
      expect(new Client('anonymous', 'secret').sendMessage(''), throwsArgumentError);
    });

    var password = Platform.environment['FREEMOBILE_PASSWORD'];
    var username = Platform.environment['FREEMOBILE_USERNAME'];
    if (password != null && username != null) test('should send valid messages with valid credentials', () {
      expect(new Client(username, password).sendMessage('Bonjour Cédric !'), completes);
    });
  });
});
