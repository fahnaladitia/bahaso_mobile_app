class BaseException implements Exception {
  final String message;
  final int? code;
  final bool success;

  BaseException({
    required this.message,
    this.code,
    this.success = false,
  });

  @override
  String toString() => 'BaseException(message: $message, code: $code, success: $success)';
}
