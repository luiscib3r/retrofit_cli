// ignore_for_file: constant_identifier_names

enum ApiMethod {
  GET,
  POST,
  PUT,
  DELETE;

  factory ApiMethod.fromString(String method) {
    switch (method.toLowerCase().trim()) {
      case 'get':
        return ApiMethod.GET;
      case 'post':
        return ApiMethod.POST;
      case 'put':
        return ApiMethod.PUT;
      case 'delete':
        return ApiMethod.DELETE;
      default:
        throw UnrecognizedMethod(method);
    }
  }
}

class UnrecognizedMethod implements Exception {
  UnrecognizedMethod(this.method);

  final String method;

  @override
  String toString() {
    return 'Method $method are not recognized.';
  }
}
