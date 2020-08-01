class AppException implements Exception {
  final _message;
  final _prefix;
  
AppException(this._message, this._prefix);
  
String toString() {
    return "$_prefix$_message";
  }
}

/// When status code is 500 and Others.
/// Throw BadRequest UnauthorisedException
class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

/// When status code is 400.
/// Throw BadRequest Exceiption
class BadRequestException extends AppException {
  BadRequestException(message) : super(message, "Invalid Request: ");
}

/// When status code is 401 and 403.
/// Throw BadRequest UnauthorisedException
class UnauthorisedException extends AppException {
  UnauthorisedException(message) : super(message, "Unauthorised: ");
}

