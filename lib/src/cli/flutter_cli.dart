part of 'cli.dart';

class PubspecNotFound implements Exception {}

class Flutter {
  static Future<bool> installed({
    required Logger logger,
  }) async {
    try {
      await _Cmd.run('flutter', ['--version'], logger: logger);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> packagesGet({
    String cwd = '.',
    bool recursive = false,
    required Logger logger,
  }) async {
    await _runCommand(
      cmd: (cwd) async {
        final installProgress = logger.progress(
          'Running "flutter packages get" in $cwd',
        );

        try {
          await _verifyGitDependencies(cwd, logger: logger);
        } catch (_) {
          installProgress.fail();
          rethrow;
        }

        try {
          await _Cmd.run(
            'flutter',
            ['packages', 'get'],
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

  static Future<void> buildRunner({
    String cwd = '.',
    bool recursive = false,
    required Logger logger,
  }) async {
    await _runCommand(
      cmd: (cwd) async {
        final buildProgress = logger.progress(
          'Running "flutter pub run build_runner build" in $cwd',
        );

        try {
          await _Cmd.run(
            'flutter',
            ['pub', 'run', 'build_runner', 'build'],
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

Future<void> _verifyGitDependencies(
  String cwd, {
  required Logger logger,
}) async {
  final pubspec = Pubspec.parse(
    await File(p.join(cwd, 'pubspec.yaml')).readAsString(),
  );

  final dependencies = pubspec.dependencies;
  final devDependencies = pubspec.devDependencies;
  final dependencyOverrides = pubspec.dependencyOverrides;
  final gitDependencies = [
    ...dependencies.entries,
    ...devDependencies.entries,
    ...dependencyOverrides.entries
  ]
      .where((entry) => entry.value is GitDependency)
      .map((entry) => entry.value)
      .cast<GitDependency>()
      .toList();

  await Future.wait(
    gitDependencies.map(
      (dependency) => Git.reachable(
        dependency.url,
        logger: logger,
      ),
    ),
  );
}

Future<List<T>> _runCommand<T>({
  required Future<T> Function(String cwd) cmd,
  required String cwd,
  required bool recursive,
}) async {
  if (!recursive) {
    final pubspec = File(p.join(cwd, 'pubspec.yaml'));
    if (!pubspec.existsSync()) throw PubspecNotFound();

    return [await cmd(cwd)];
  }

  final processes = _Cmd.runWhere<T>(
    run: (entity) => cmd(entity.parent.path),
    where: _isPubspec,
    cwd: cwd,
  );

  if (processes.isEmpty) throw PubspecNotFound();

  final results = <T>[];
  for (final process in processes) {
    results.add(await process);
  }
  return results;
}
