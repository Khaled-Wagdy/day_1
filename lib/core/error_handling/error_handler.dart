import 'package:dio/dio.dart';
import 'app_exception.dart';

/// Converts a [DioException] or any generic [Exception] into a typed [AppException].
AppException handleDioError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'Connection timed out. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const NoInternetException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final serverMessage =
            error.response?.data?['message']?.toString() ??
            'An error occurred on the server.';

        if (statusCode == 401) {
          return const UnauthorizedException();
        }

        return ServerException(
          message: serverMessage,
          statusCode: statusCode,
          details: 'Status code: $statusCode',
        );

      case DioExceptionType.cancel:
        return const NetworkException(message: 'Request was cancelled.');

      default:
        return NetworkException(
          message: error.message ?? 'Unexpected network error.',
        );
    }
  }

  if (error is FormatException) {
    return ParseException(
      message: 'Failed to parse server response.',
      details: error.message,
    );
  }

  return NetworkException(message: error.toString());
}
