part of 'cli.dart';

class UnreachableGitDependency implements Exception {
  const UnreachableGitDependency({required this.remote});

  final Uri remote;

  @override
  String toString() {
    return '''
$remote is unreachable.
Make sure the remote exists and you have the correct access rights.''';
  }
}

class Git {
  static Future<void> reachable(
    Uri remote, {
    required Logger logger,
  }) async {
    try {
      await _Cmd.run(
        'git',
        ['ls-remote', '$remote', '--exit-code'],
        logger: logger,
      );
    } catch (_) {
      throw UnreachableGitDependency(remote: remote);
    }
  }
}
