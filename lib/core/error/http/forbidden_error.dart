import '../http_error.dart';

class ForbiddenError extends HttpError {
  @override
  String toString() {
    return 'Forbidden';
  }
}