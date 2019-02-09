part of '../free_mobile.dart';

/// Sends messages by SMS to a [Free Mobile](http://mobile.free.fr) account.
class Client {

  /// Creates a new client.
  /// Throws an [ArgumentError] if the account credentials are invalid.
  Client(this.username, this.password, {Uri endPoint}): endPoint = endPoint ?? Uri.https('smsapi.free-mobile.fr', '/') {
    if (username.isEmpty || password.isEmpty) throw ArgumentError('The account credentials are invalid');
  }

  /// The stream of "request" events.
  Stream<http.Request> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<http.Response> get onResponse => _onResponse.stream;

  /// The URL of the API end point.
  final Uri endPoint;

  /// The identification key associated to the account.
  final String password;

  /// The user name associated to the account.
  final String username;

  /// The handler of "request" events.
  final StreamController<http.Request> _onRequest = StreamController<http.Request>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = StreamController<http.Response>.broadcast();

  /// Sends a SMS message to the underlying account.
  ///
  /// Throws an [ArgumentError] if the specified message is empty.
  /// Throws a [http.ClientException] if an error occurred while sending the message.
  Future<void> sendMessage(String text) async {
    final message = text.trim();
    if (message.isEmpty) throw ArgumentError('The specified message is empty');

    final httpClient = http.Client();
    final request = http.Request('GET', endPoint.replace(path: '/sendmsg', queryParameters: <String, String>{
      'msg': message.substring(0, math.min(message.length, 160)),
      'pass': password,
      'user': username
    }));

    try {
      _onRequest.add(request);
      final response = await httpClient.get(request.url);
      _onResponse.add(response);

      if ((response.statusCode ~/ 100) != 2)
        throw http.ClientException('An error occurred while sending the message', request.url);

      return response.body;
    }

    on Exception catch (err) {
      if (err is http.ClientException) rethrow;
      throw http.ClientException(err.toString(), request.url);
    }

    finally {
      httpClient.close();
    }
  }
}
