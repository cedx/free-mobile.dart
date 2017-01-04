# Free Mobile for Dart
![Release](https://img.shields.io/pub/v/free_mobile.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Build](https://travis-ci.org/cedx/free-mobile.dart.svg)

Send SMS messages to your [Free Mobile](http://mobile.free.fr) account, in [Dart](https://www.dartlang.org).

To use this library, you must have enabled SMS Notifications in the Options of your [Subscriber Area](https://mobile.free.fr/moncompte).

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.
If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) version.

## Installing via [Pub](https://pub.dartlang.org)

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  free_mobile: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
$ pub get
```

### 3. Import it
Now in your [Dart](https://www.dartlang.org) code, you can use:

```dart
import 'package:free_mobile/free_mobile.dart' as free_mobile;
```

## Usage
This package provides a single class, [`Client`](https://github.com/cedx/free-mobile.dart/blob/master/lib/src/client.dart), which allow to send messages to your mobile phone by using the `sendMessage()` method:

```dart
try {
  var client = new free_mobile.Client('your user name', 'your identification key');
  await client.sendMessage('Hello World!');
  print('The message was sent successfully.');
}

catch (error) {
  print('An error occurred: $error');
}
```

The text of the messages will be automatically truncated to 160 characters: you can't send multipart messages using this library.

There is also a convenient `sendMessage()` function:

```dart
await free_mobile.sendMessage('Hello World!',
  username: 'your user name',
  password: 'your identification key'
);

print('The message was sent successfully.');
```

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

## Unit tests
In order to run the tests, you must set two environment variables:

```shell
$ export FREEMOBILE_USERNAME="<your Free Mobile user name>"
$ export FREEMOBILE_PASSWORD="<your Free Mobile identification key>"
```

Then, you can run the `test` script from the command prompt:

```shell
$ pub run test
```

## See also
- [API reference](https://cedx.github.io/free-mobile.dart)
- [Continuous integration](https://travis-ci.org/cedx/free-mobile.dart)

## License
[Free Mobile for Dart](https://github.com/cedx/free-mobile.dart) is distributed under the Apache License, version 2.0.
