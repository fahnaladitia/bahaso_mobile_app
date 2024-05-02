import 'package:dio/dio.dart';

import '../../../../core/common/exceptions/exceptions.dart';

abstract class BaseService {
  final Dio dio;

  BaseService(this.dio);
  Options applyOptions({Map<String, dynamic>? extra}) {
    return Options(extra: extra);
  }

  BaseException exceptionHandler(
    DioException e, {
    String? Function(dynamic data)? onBadResponse,
  }) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return BaseException(
          message: noInternetConnectionError,
          code: e.response?.statusCode,
        );
      case DioExceptionType.sendTimeout:
        return BaseException(
          message: sendTimeoutError,
          code: e.response?.statusCode,
        );
      case DioExceptionType.receiveTimeout:
        return BaseException(
          message: receiveTimeoutError,
          code: e.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        final badResponseMessage = onBadResponse?.call(e.response?.data);
        return BaseException(
          message: badResponseMessage ?? 'Bad response: ${e.message}',
          code: e.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return BaseException(message: cancelError, code: e.response?.statusCode);
      case DioExceptionType.badCertificate:
        return BaseException(message: badCertificateError, code: e.response?.statusCode);
      case DioExceptionType.connectionError:
        // No internet connection or Connection Error
        return BaseException(message: noInternetConnectionOrConnectionError, code: e.response?.statusCode);
      case DioExceptionType.unknown:
        return BaseException(message: unknownError, code: e.response?.statusCode);
      default:
        return BaseException(
          message: e.message ?? unknownError,
          code: e.response?.statusCode,
        );
    }
  }
}
