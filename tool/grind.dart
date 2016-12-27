import 'dart:async';
import 'package:grinder/grinder.dart';

/// Starts the build system.
Future main(List<String> args) => grind(args);

/// Deletes all generated files and reset any saved state.
@Task()
void clean() => defaultClean();

/// Sends the results of the code coverage.
@Task()
void coverage() {
  // TODO
}

/// Builds the documentation.
@Task()
void doc() => DartDoc.doc();

/// Fixes the coding standards issues.
@Task()
void fix() {
  DartFmt.format('lib');
  DartFmt.format('test');
  DartFmt.format('tool');
}

/// Performs static analysis of source code.
@Task()
void lint() {
  Analyzer.analyze('lib');
  Analyzer.analyze('test');
  Analyzer.analyze('tool');
}

/// Runs the unit tests.
@Task()
void test() => new TestRunner().test();
