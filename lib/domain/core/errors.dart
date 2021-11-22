import 'failures.dart';

class UnexpectedValueError<T> extends Error {
  ValueFailure<T> valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating';
    // Errors shouldn't have some some weird characters.
    // Therefore we'll use safeToString
    return Error.safeToString('$explanation. Failure was $valueFailure');
  }
}
