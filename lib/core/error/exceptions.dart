class ServerException implements Exception {
  ServerException(this.message);
  final String message;

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  NetworkException([this.message = 'No internet connection']);
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  CacheException(this.message);
  final String message;

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  ValidationException(this.message);
  final String message;

  @override
  String toString() => 'ValidationException: $message';
}
