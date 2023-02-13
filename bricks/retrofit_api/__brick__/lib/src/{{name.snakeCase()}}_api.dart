import 'package:diox/diox.dart';
import 'package:retrofit/retrofit.dart';
import 'package:{{name.snakeCase()}}_api/{{name.snakeCase()}}_api.dart';

export 'models/models.dart';
export 'payloads/payloads.dart';
export 'responses/responses.dart';

part '{{name.snakeCase()}}_api.g.dart';

/// {@template {{name.snakeCase()}}_api}
/// {{name.camelCase()}} Api
/// {@endtemplate}
@RestApi()
abstract class {{name.pascalCase()}}Api {
  /// {@macro {{name.snakeCase()}}_api}
  factory {{name.pascalCase()}}Api(Dio dio, {String baseUrl}) = _{{name.pascalCase()}}Api;

  {{#endpoints}}
  @{{method}}('{{{url}}}')
  Future<{{#response.isList}}List<{{/response.isList}}{{response.name.pascalCase()}}{{#response.isList}}>{{/response.isList}}> {{name.camelCase()}}({{^emptyArgs}}{{open}}{{/emptyArgs}}
    {{#headers}}
    @Header('{{name}}') required String {{name.camelCase()}},
    {{/headers}}
    {{#paths}}
    @Path('{{name}}') required {{type}} {{name.camelCase()}},
    {{/paths}}
    {{#params}}
    @Query('{{name}}') {{type}}? {{name.camelCase()}},
    {{/params}}
    {{#payload}}
    @Body() required {{#payload.isList}}List<{{/payload.isList}}{{payload.name.pascalCase()}}{{#payload.isList}}>{{/payload.isList}} payload,
    {{/payload}}
  {{^emptyArgs}}{{close}}{{/emptyArgs}});
  {{/endpoints}}
}
