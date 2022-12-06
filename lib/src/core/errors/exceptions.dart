class ServerException implements Exception {}

class NotFoundException implements Exception {}

class CacheException implements Exception {
  final Object? innerException;

  CacheException([this.innerException]);
}
