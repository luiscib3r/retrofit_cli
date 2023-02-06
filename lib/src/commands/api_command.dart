import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:retrofit_cli/src/bundles/bundles.dart';
import 'package:retrofit_cli/src/cli/cli.dart';
import 'package:retrofit_cli/src/entities/entities.dart';
import 'package:yaml/yaml.dart';

abstract class ApiOptions {
  static const output = 'output';
  static const input = 'input';
}

class ApiCommand extends Command<int> {
  ApiCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        ApiOptions.output,
        abbr: 'o',
        help: 'The desired output directory when creating the package.',
        defaultsTo: './api',
      )
      ..addOption(
        ApiOptions.input,
        abbr: 'i',
        help: 'Input api configuration file.',
        defaultsTo: 'api.yaml',
      );
  }

  @override
  String get name => 'api';

  @override
  String get description => 'Generate API';

  final Logger _logger;

  Directory get _outputDirectory {
    final directory = argResults?[ApiOptions.output] as String? ?? './api';
    return Directory(directory);
  }

  File get _inputFile {
    final input = argResults?[ApiOptions.input] as String? ?? 'api.yaml';

    return File(input);
  }

  @override
  FutureOr<int>? run() async {
    final outputDirectory = _outputDirectory;
    final inputFile = _inputFile;
    _logger
      ..info('Output Directory: ${outputDirectory.path}')
      ..info('Input File: ${inputFile.path}');

    try {
      // Parse yaml
      final doc = await _readYamlFromFile(inputFile);
      final apiSetup = ApiSetup.fromYaml(doc, logger: _logger);

      // Generators
      final retrofitGenerator = await MasonGenerator.fromBundle(
        retrofitApiBundle,
      );
      final classGenerator = await MasonGenerator.fromBundle(classTypeBundle);
      final indexGenerator = await MasonGenerator.fromBundle(indexFileBundle);

      // Target Directory
      final target = DirectoryGeneratorTarget(outputDirectory);

      // Responses
      final responses = apiSetup.responses;
      final responsesFiles = apiSetup.responsesFiles;

      // Payloads
      final payloads = apiSetup.payloads;
      final payloadsFiles = apiSetup.payloadsFiles;

      // Models
      final models = apiSetup.models;
      final modelsFiles = apiSetup.modelsFiles;

      // Generate Base Package
      final retrofitProgress = _logger.progress(
        'Generating base package',
      );
      await retrofitGenerator.generate(
        target,
        vars: apiSetup.toJson(),
      );
      retrofitProgress.complete();

      // Generate Responses
      final responsesProgress = _logger.progress(
        'Generating responses',
      );
      for (final response in responses) {
        await classGenerator.generate(target, vars: response);
      }
      responsesProgress.complete();

      // Generate Payloads
      final payloadsProgress = _logger.progress(
        'Generating payloads',
      );
      for (final payload in payloads) {
        await classGenerator.generate(target, vars: payload);
      }
      payloadsProgress.complete();

      // Generate Models
      final modelsProgress = _logger.progress(
        'Generating models',
      );
      for (final model in models) {
        await classGenerator.generate(target, vars: model);
      }
      modelsProgress.complete();

      // Generate Index files
      final indexProgress = _logger.progress(
        'Generating index files',
      );
      await indexGenerator.generate(target, vars: responsesFiles);
      await indexGenerator.generate(target, vars: payloadsFiles);
      await indexGenerator.generate(target, vars: modelsFiles);
      indexProgress.complete();

      // Post generate actions
      await installDartPackages(_logger, outputDirectory);
      await applyDartFixes(_logger, outputDirectory);
      await runBuildRunner(_logger, outputDirectory);
      await dartFormat(_logger, outputDirectory);
    } catch (e) {
      _logger.err(e.toString());
    }

    return 0;
  }

  Future<YamlMap> _readYamlFromFile(File inputFile) async {
    final yaml = await inputFile.readAsString();

    final doc = loadYaml(yaml) as YamlMap;

    return doc;
  }
}
