import 'dart:async';
import 'dart:io';
import 'package:grinder/grinder.dart';

/// Starts the build system.
Future main(List<String> args) => grind(args);

/// Deletes all generated files and reset any saved state.
@Task()
void clean() => defaultClean();

/// Sends the results of the code coverage.
@Task()
void coverage({bool collect = false}) {
  if (collect) {
    Dart.runAsync('test/all.dart', vmArgs: ['--checked', '--enable-vm-service', '--pause-isolates-on-exit']);
    Pub.run('coverage', script: 'collect_coverage', arguments: ['--out=var/coverage.json', '--resume-isolates']);
    Pub.run('coverage', script: 'format_coverage', arguments: ['--in=var/coverage.json', '--lcov', '--out=var/coverage.lcov']);
  }

  //var endPoint = Uri.parse('https://coveralls.io/api/v1/jobs');
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
