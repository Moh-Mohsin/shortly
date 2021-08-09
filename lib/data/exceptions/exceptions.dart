/// Parent class for all the exceptions thrown by the App.
abstract class AppException implements Exception {
  final String msg;

  AppException(this.msg);
}

/// This exception will be thrown in case of server failures in the data layer.
class ServerException extends AppException {
  ServerException() : super("Server Error");
}

class BadRequestException extends AppException {
  BadRequestException() : super("Please enter a valid link");
}

class NetworkException extends AppException {
  NetworkException()
      : super("Failed to connect. are you connected to the internet?");
}

class GeneralException extends AppException {
  final String msg;

  GeneralException(this.msg) : super(msg);
}