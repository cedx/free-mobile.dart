import 'dart:io';
import 'package:test/test.dart';
import '../lib/free_mobile.dart';

/// Tests the features of the `Client` class.
void main() {
  group('.sendMessage()', () {
    test('should not send valid messages with invalid credentials', () {
      expect(new Client().sendMessage('Hello World!'), throwsArgumentError);
    });

    test('should not send invalid messages with valid credentials', () {
      expect(new Client('anonymous', 'secret').sendMessage(''), throwsArgumentError);
    });

    var password = Platform.environment['FREEMOBILE_PASSWORD'];
    var username = Platform.environment['FREEMOBILE_USERNAME'];
    if (password != null && username != null) test('should send valid messages with valid credentials', () {
      expect(new Client(username, password).sendMessage('Bonjour Cédric !'), completion(returnsNormally));
    });
  });

  group('.toJson()', () {
    test('should return an object instance with the same public values', () {
      var data = new Client('anonymous', 'secret').toJson();
      expect(data, isMap);
      expect(data, hasLength(2));
      expect(data['password'], equals('secret'));
      expect(data['username'], equals('anonymous'));
    });
  });
}
