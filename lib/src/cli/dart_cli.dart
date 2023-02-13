part of 'cli.dart';

class Dart {
  static Future<bool> installed({
    required Logger logger,
  }) async {
    try {
      await _Cmd.run('dart', ['--version'], logger: logger);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> applyFixes({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
  }) async {
    if (!recursive) {
      final pubspec = File(p.join(cwd, 'pubspec.yaml'));
      if (!pubspec.existsSync()) throw PubspecNotFound();

      await _Cmd.run(
        'dart',
        ['fix', '--apply'],
        workingDirectory: cwd,
        logger: logger,
      );
      return;
    }

    final processes = _Cmd.runWhere(
      run: (entity) => _Cmd.run(
        'dart',
        ['fix', '--apply'],
        workingDirectory: entity.parent.path,
        logger: logger,
      ),
      where: _isPubspec,
      cwd: cwd,
    );

    if (processes.isEmpty) throw PubspecNotFound();

    await Future.wait<void>(processes);
  }

  static Future<void> packagesGet({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
  }) async {
    await _runCommand(
      cmd: (cwd) async {
        final installProgress = logger.progress(
          'Running "dart pub get" in $cwd',
        );

        try {
          await _verifyGitDependencies(cwd, logger: logger);
        } catch (_) {
          installProgress.fail();
          rethrow;
        }

        try {
          await _Cmd.run(
            'dart',
            ['pub', 'get'],
            workingDirectory: cwd,
            logger: logger,
          );
        } finally {
          installProgress.complete();
        }
      },
      cwd: cwd,
      recursive: recursive,
    );
  }

  static Future<void> format({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
  }) async {
    await _runCommand(
      cmd: (cwd) async {
        final buildProgress = logger.progress(
          'Running "dart format" in $cwd',
        );

        try {
          await _Cmd.run(
            'dart',
            ['format', '.'],
            workingDirectory: cwd,
            logger: logger,
          );
        } finally {
          buildProgress.complete();
        }
      },
      cwd: cwd,
      recursive: recursive,
    );
  }

  static Future<void> buildRunner({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
  }) async {
    await _runCommand(
      cmd: (cwd) async {
        final buildProgress = logger.progress(
          'Running "dart run build_runner build" in $cwd',
        );

        try {
          await _Cmd.run(
            'dart',
            ['run', 'build_runner', 'build'],
            workingDirectory: cwd,
            logger: logger,
          );
        } finally {
          buildProgress.complete();
        }
      },
      cwd: cwd,
      recursive: recursive,
    );
  }
}
