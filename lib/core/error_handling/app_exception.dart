/// Base class for all app-level exceptions
abstract class AppException implements Exception {
  final String message;
  final String? details;

  const AppException({required this.message, this.details});

  @override
  String toString() => details != null ? '$message\n$details' : message;
}

/// Thrown when a network/API call fails
class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException({
    required super.message,
    super.details,
    this.statusCode,
  });
}

/// Thrown when response JSON parsing fails
class ParseException extends AppException {
  const ParseException({required super.message, super.details});
}

/// Thrown when the server returns an error response
class ServerException extends AppException {
  final int statusCode;

  const ServerException({
    required super.message,
    required this.statusCode,
    super.details,
  });
}

/// Thrown when the user is not authorized (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized. Please login again.',
    super.details,
  });
}

/// Thrown when there is no internet connection
class NoInternetException extends AppException {
  const NoInternetException({
    super.message = 'No internet connection. Please check your network.',
    super.details,
  });
}
