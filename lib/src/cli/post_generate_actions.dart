import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:retrofit_cli/src/cli/cli.dart';

Future<void> installFlutterPackages(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isFlutterInstalled = await Flutter.installed(logger: logger);
  if (isFlutterInstalled) {
    await Flutter.packagesGet(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
}

Future<void> installDartPackages(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    await Dart.packagesGet(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
}

Future<void> runBuildRunner(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    await Dart.buildRunner(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
}

Future<void> dartFormat(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    await Dart.format(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
}

Future<void> applyDartFixes(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    final applyFixesProgress = logger.progress(
      'Running "dart fix --apply" in ${outputDir.path}',
    );
    await Dart.applyFixes(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
    applyFixesProgress.complete();
  }
}
