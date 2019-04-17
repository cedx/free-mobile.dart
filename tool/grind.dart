import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:grinder/grinder.dart';
import 'package:pedantic/pedantic.dart';

/// Starts the build system.
Future<void> main(List<String> args) => grind(args);

@Task('Deletes all generated files and reset any saved state')
void clean() {
  defaultClean();
  ['.dart_tool/build', 'doc/api', webDir.path].map(getDir).forEach(delete);
  FileSet.fromDir(getDir('var'), pattern: '*.{info,json}', recurse: true).files.forEach(delete);
}

@Task('Uploads the results of the code coverage')
void coverage() {
  final report = getFile('var/lcov.info');
  if (report.existsSync()) Pub.run('coveralls', arguments: [report.path]);
}

@Task('Builds the documentation')
Future<void> doc() async {
  for (final path in ['CHANGELOG.md', 'LICENSE.md']) await getFile(path).copy('doc/about/${path.toLowerCase()}');
  DartDoc.doc();
  run('mkdocs', arguments: ['build', '--config-file=doc/mkdocs.yml']);
  ['doc/about/changelog.md', 'doc/about/license.md', '${webDir.path}/mkdocs.yml'].map(getFile).forEach(delete);
}

@Task('Fixes the coding standards issues')
void fix() => DartFmt.format(existingSourceDirs);

@Task('Performs the static analysis of source code')
void lint() => Analyzer.analyze(existingSourceDirs);

@Task('Runs the test suites')
Future<void> test() async {
  final args = context.invocation.arguments;
  return (args.hasOption('platform') ? args.getOption('platform') : 'vm') == 'browser'
    ? Pub.runAsync('build_runner', arguments: ['test', '--delete-conflicting-outputs', '--', '--platform=firefox'])
    : _collectCoverage(getFile('test/all.dart'));
}

@Task('Upgrades the project to the latest revision')
void upgrade() {
  run('git', arguments: ['reset', '--hard']);
  run('git', arguments: ['fetch', '--all', '--prune']);
  run('git', arguments: ['pull', '--rebase']);
  Pub.upgrade();
}

@Task('Watches for file changes')
void watch() => Pub.run('build_runner', arguments: ['watch', '--delete-conflicting-outputs']);

/// Collects the code coverage by running the specified test file.
Future<void> _collectCoverage(File testFile) async {
  await Pub.runAsync('coverage', script: 'collect_coverage', arguments: [
    '--out=var/coverage.json',
    '--resume-isolates',
    '--uri=${await _profileTest(testFile)}',
    '--wait-paused'
  ]);

  return Pub.runAsync('coverage', script: 'format_coverage', arguments: [
    '--in=var/coverage.json',
    '--lcov',
    '--out=var/lcov.info',
    '--packages=.packages',
    '--report-on=${libDir.path}'
  ]);
}

/// Profiles the execution of the specified test file.
/// Returns the URI that Observatory is listening on.
Future<Uri> _profileTest(File testFile) async {
  var counter = 0;
  final completer = Completer<Uri>();
  final process = await Process.start('dart', [
    '-Dpassword=${Platform.environment['FREEMOBILE_PASSWORD']}',
    '-Dusername=${Platform.environment['FREEMOBILE_USERNAME']}',
    '--enable-vm-service',
    '--pause-isolates-on-exit',
    testFile.path
  ]);

  process.stderr.transform(utf8.decoder).listen((data) => print(data.trimRight()));
  process.stdout.transform(utf8.decoder).listen((data) {
    print(data.trimRight());
    if (++counter == 1) {
      final match = RegExp(r'^Observatory listening on (.*)').firstMatch(data);
      final uri = match != null ? match[1].trim() : 'http://127.0.0.1:8181/';
      completer.complete(Uri.parse(uri));
    }
  });

  unawaited(process.exitCode.then((code) => exitCode = code));
  return completer.future;
}
