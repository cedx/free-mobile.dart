import 'package:free_mobile/free_mobile.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('.sendMessage()', () {
    test('should throw a `ClientException` if a network error occurred', () {
      final client = Client('anonymous', 'secret', endPoint: Uri.http('localhost', '/'));
      expect(() => client.sendMessage('Bonjour Cédric !'), throwsA(const TypeMatcher<ClientException>()));
    });

    test('should send SMS messages if credentials are valid', () {
      const username = String.fromEnvironment('username');
      const password = String.fromEnvironment('password');
      expect(Client(username, password).sendMessage('Bonjour Cédric, à partir de Dart !'), completes);
    });
  });
});
