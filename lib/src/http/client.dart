part of free_mobile.http;

/// Sends messages by SMS to a [Free Mobile](http://mobile.free.fr) account.
class Client {

  /// The URL of the default API end point.
  static final Uri defaultEndPoint = Uri.parse('https://smsapi.free-mobile.fr');

  /// Creates a new client.
  Client(this.username, this.password, {Uri endPoint}): endPoint = endPoint ?? defaultEndPoint;

  /// The stream of "request" events.
  Stream<RequestEvent> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<RequestEvent> get onResponse => _onResponse.stream;

  /// The URL of the API end point.
  final Uri endPoint;

  /// The identification key associated to the account.
  final String password;

  /// The user name associated to the account.
  final String username;

  /// The handler of "request" events.
  final StreamController<RequestEvent> _onRequest = new StreamController<RequestEvent>.broadcast();

  /// The handler of "response" events.
  final StreamController<RequestEvent> _onResponse = new StreamController<RequestEvent>.broadcast();

  /// Sends a SMS message to the underlying account.
  /// Throws an [ArgumentError] if the account credentials are invalid or the specified message is empty.
  Future sendMessage(String text) async {
    if (username.isEmpty || password.isEmpty) throw new ArgumentError('The account credentials are invalid.');

    var message = text.trim();
    if (message.isEmpty) throw new ArgumentError('The specified message is empty.');

    var httpClient = newHttpClient();
    var request = new http.Request('GET', endPoint.replace(path: 'sendmsg', queryParameters: {
      'msg': message.substring(0, math.min(message.length, 160)),
      'pass': password,
      'user': username
    }));

    _onRequest.add(new RequestEvent(request));
    var response = await httpClient.get(request.url);
    _onResponse.add(new RequestEvent(request, response));
    httpClient.close();

    if ((response.statusCode / 100).truncate() != 2)
      throw new http.ClientException('An error occurred while sending the message.', request.url);

    return response.body;
  }
}

/// The event parameter used for request events.
class RequestEvent {

  /// Creates a new request event.
  RequestEvent(this.request, [this.response]);

  /// The client request.
  final http.Request request;

  /// The server response.
  final http.Response response;
}
