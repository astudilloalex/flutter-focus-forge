class CustomHttpException implements Exception {
  const CustomHttpException({
    this.code = 0,
    this.message = '',
  });

  final int code;
  final String message;
}
