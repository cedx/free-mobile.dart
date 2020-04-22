---
path: src/branch/master
source: lib/src/client.dart
---

# Usage

## SMS notifications
**Free Mobile for Dart** provides the `Client` class, which allow to send SMS messages to your mobile phone by using the `sendMessage()` method:

```dart
import 'package:free_mobile/free_mobile.dart';

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
```

The `Client.sendMessage()` method returns a [`Future`](https://api.dart.dev/stable/dart-async/Future-class.html) that completes when the message has been sent.

It completes with a `ClientException` if any error occurred while sending the message.

!!! warning
    The text of the messages will be automatically truncated to **160** characters:  
    you can't send multipart messages using this library.

## Client events
The `Client` class triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
client.onRequest.listen(
  (request) => print('Client request: ${request.url}')
);

client.onResponse.listen(
  (response) => print('Server response: ${response.statusCode}')
);
```
