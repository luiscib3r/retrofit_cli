import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

export 'post_generate_actions.dart';

part 'dart_cli.dart';
part 'flutter_cli.dart';
part 'git_cli.dart';

class _Cmd {
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? workingDirectory,
    required Logger logger,
  }) async {
    logger.detail('Running $cmd with $args');
    const runProcess = Process.run;

    final result = await runProcess(
      cmd,
      args,
      workingDirectory: workingDirectory,
      runInShell: true,
    );

    logger
      ..detail('stdout:\n${result.stdout}')
      ..detail('stderr:\n${result.stderr}');

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args);
    }
    return result;
  }

  static Iterable<Future<T>> runWhere<T>({
    required Future<T> Function(FileSystemEntity) run,
    required bool Function(FileSystemEntity) where,
    String cwd = '.',
  }) {
    return Directory(cwd).listSync(recursive: true).where(where).map(run);
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);

      var message = 'Unknown error';
      if (values.isNotEmpty) {
        message = values.entries.map((e) => '${e.key}\n${e.value}').join('\n');
      }

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}

const _ignoredDirectories = {
  'ios',
  'android',
  'windows',
  'linux',
  'macos',
  '.symlinks',
  '.plugin_symlinks',
  '.dart_tool',
  'build',
  '.fvm',
};

bool _isPubspec(FileSystemEntity entity) {
  final segments = p.split(entity.path).toSet();
  if (segments.intersection(_ignoredDirectories).isNotEmpty) return false;
  if (entity is! File) return false;
  return p.basename(entity.path) == 'pubspec.yaml';
}
