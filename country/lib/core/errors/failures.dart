abstract class Failure {
  final String message;
  final StackTrace? stackTrace;

  Failure(this.message, [this.stackTrace]);
}

// Corresponding failures for exceptions
class ServerFailure extends Failure {
  ServerFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

class CacheFailure extends Failure {
  CacheFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}
