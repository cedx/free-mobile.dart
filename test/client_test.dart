import 'dart:io';
import 'package:free_mobile/free_mobile.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('.sendMessage()', () {
    test('should throw a `ClientException` if a network error occurred', () {
      final client = Client('anonymous', 'secret', endPoint: Uri.http('localhost:10000', '/'));
      expect(() => client.sendMessage('Bonjour Cédric !'), throwsA(const TypeMatcher<ClientException>()));
    });

    test('should send SMS messages if credentials are valid', () {
      final username = Platform.environment['FREEMOBILE_USERNAME'];
      final password = Platform.environment['FREEMOBILE_PASSWORD'];
      expect(Client(username, password).sendMessage('Bonjour Cédric, à partir de Dart !'), completes);
    });
  });
});
