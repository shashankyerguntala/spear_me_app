class Failure {
  final String message;
  Failure(this.message);
}

class ServerError extends Failure {
  ServerError(super.message);
}

class ClientError extends Failure {
  ClientError(super.message);
}

class UnauthorizedAccess extends Failure {
  UnauthorizedAccess(super.message);
}
