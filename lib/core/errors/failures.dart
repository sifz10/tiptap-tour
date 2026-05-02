sealed class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class P2PFailure extends Failure {
  const P2PFailure(super.message);
}

class SyncFailure extends Failure {
  const SyncFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
