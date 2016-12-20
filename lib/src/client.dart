part of freemobile;

/// Sends messages by SMS to a [Free Mobile](http://mobile.free.fr) account.
class Client {

  /// The URL of the API end point.
  static final Uri endPoint = Uri.parse('https://smsapi.free-mobile.fr/sendmsg');

  /// Creates a new client.
  Client([this.username, this.password]);

  /// The stream of "request" events.
  Stream<HttpRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<HttpResponse> get onResponse => _onResponse.stream;

  /// The identification key associated to the account.
  String password;

  /// The user name associated to the account.
  String username;

  /// The handler of "request" events.
  StreamController<HttpRequest> _onRequest = new StreamController<HttpRequest>.broadcast();

  /// The handler of "response" events.
  StreamController<HttpResponse> _onResponse = new StreamController<HttpResponse>.broadcast();

  /**
   * Sends a SMS message to the underlying account.
   * @param {string} text The text of the message to send.
   * @return {Observable<string>} The response as string.
   * @emits {superagent.Request} The "request" event.
   * @emits {superagent.Response} The "response" event.
   */
  sendMessage(text) {
    // TODO
    return null;
  }

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() => {
    'password': password,
    'username': username
  };

  /// Returns a string representation of this object.
  @override String toString() => '${runtimeType} ${JSON.encode(this)}';
}
