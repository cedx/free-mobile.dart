# Free Mobile for Dart
![Release](https://img.shields.io/pub/v/free_mobile.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Build](https://img.shields.io/travis/cedx/free_mobile.dart.svg)

Send SMS messages to your [Free Mobile](http://mobile.free.fr) account, in [Dart](https://www.dartlang.org).

To use this library, you must have enabled SMS Notifications in the Options of your [Subscriber Area](https://mobile.free.fr/moncompte).

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.

## Installing via [Pub](https://pub.dartlang.org)

### Depend on it
Add this to your package's `pubspec.yaml` file::

```yaml
dependencies:
  free_mobile: *
```

### Install it
You can install the dependencies from a command prompt:

```shell
$ pub get
```

## Usage
This package provides a single class, `Client`, which allow to send messages to your mobile phone by using the `sendMessage()` method:

```dart
try {
  var client = new Client('<user name>', '<identification key>');
  await client.sendMessage('Hello World!');
  print('The message was sent successfully.');
}

catch (error) {
  print('An error occurred: ${error}');
}
```

The text of the messages will be automatically truncated to 160 characters: you can't send multipart messages using this library.

## Events
The `Client` class triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream`](https://api.dartlang.org/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
client.onRequest.listen(
  (request) => print('Client request: ${request.url}')
);

client.onResponse.listen(
  (response) => print('Server response: ${response.statusCode}')
);
```

## Unit Tests
In order to run the tests, you must set two environment variables:

```shell
$ export FREEMOBILE_USERNAME="<your Free Mobile user name>"
$ export FREEMOBILE_PASSWORD="<your Free Mobile identification key>"
```

Then, you can run the `test` script from the command prompt:

```shell
$ pub run test
```

## See Also
- [API Reference](https://cedx.github.io/free-mobile.dart)
- [Continuous Integration](https://travis-ci.org/cedx/free-mobile.dart)

## License
[Free Mobile for Dart](https://github.com/cedx/free-mobile.dart) is distributed under the Apache License, version 2.0.
