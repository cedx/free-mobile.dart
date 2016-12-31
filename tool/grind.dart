import 'dart:async';
import 'package:grinder/grinder.dart';

/// The list of source directories.
const List<String> _sources = const ['lib', 'test', 'tool'];

/// Starts the build system.
Future main(List<String> args) => grind(args);

/// Deletes all generated files and reset any saved state.
@Task()
void clean() => defaultClean();

/// Sends the results of the code coverage.
@Task()
Future coverage() async {
  await Future.wait([
    Dart.runAsync('test/all.dart', vmArgs: const ['--checked', '--enable-vm-service', '--pause-isolates-on-exit']),
    Pub.runAsync('coverage', script: 'collect_coverage', arguments: const ['--out=var/coverage.json', '--resume-isolates'])
  ]);

  await Pub.runAsync('coverage', script: 'format_coverage', arguments: const ['--in=var/coverage.json', '--lcov', '--out=var/coverage.lcov']);
}

/// Builds the documentation.
@Task()
void doc() => DartDoc.doc();

/// Fixes the coding standards issues.
@Task()
void fix() => DartFmt.format(_sources);

/// Performs static analysis of source code.
@Task()
void lint() => Analyzer.analyze(_sources);

/// Runs the unit tests.
@Task()
void test() => new TestRunner().test();
