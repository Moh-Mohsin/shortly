/// Parent class for all the exceptions thrown by the App.
abstract class AppException implements Exception {
  final String msg;

  AppException(this.msg);

}

/// This exception will be thrown in case of server failures in the data layer.
class ServerException extends AppException {
  ServerException() : super("Server Error");
}
