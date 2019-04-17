import 'package:free_mobile/free_mobile.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('constructor', () {
    test('should throw an error if the credentials are invalid', () {
      expect(() => Client('', '').sendMessage('Hello World!'), throwsArgumentError);
    });
  });

  group('.sendMessage()', () {
    test('should not send invalid messages', () {
      expect(() => Client('anonymous', 'secret').sendMessage(''), throwsArgumentError);
    });

    test('should throw a `ClientException` if a network error occurred', () {
      final client = Client('anonymous', 'secret', endPoint: Uri.http('localhost', '/'));
      expect(() => client.sendMessage('Bonjour Cédric !'), throwsA(const TypeMatcher<ClientException>()));
    });

    test('should send valid messages with valid credentials', () {
      final client = Client(const String.fromEnvironment('username'), const String.fromEnvironment('password'));
      expect(client.sendMessage('Bonjour Cédric !'), completes);
    }, testOn: 'vm');
  });
});
