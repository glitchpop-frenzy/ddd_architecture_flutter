import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../core/value_objects.dart';
import '../core/failures.dart';
import '../core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  // Now to clean up all kinds of mess we use Either<Left, Right>,
  // to join our Valid Value and Failed Exception (if caught) in as single value.
  // we user Either<>, which takes 2 value. Left one isgenerally used for exceptions
  // Right one is generally used for correct values.
  // final Exception failure;
  @override
  final Either<ValueFailure<String>, String> value;
  const EmailAddress._(this.value);

  // Okay, now consider a case when someone tampers with the data in the Firestore DB
  // once the user has entered it and validated it.
  // We definitely, don't want that.

  // Hence, we want to validate the EmailAddress every time we use it, for this
  // we use factory constructor

  // for validating we'll run another logic which is ValidateEmail
  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  const Password._(this.value);

  factory Password(String input) {
    return Password._(validatePassword(input));
  }
}

class UniqueID extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueID(String input) {
    return UniqueID._(right(const Uuid().v1()));
  }

  factory UniqueID.fromUniqueString(String uniqueId) {
    return UniqueID._(right(uniqueId));
  }
  const UniqueID._(this.value);
}
