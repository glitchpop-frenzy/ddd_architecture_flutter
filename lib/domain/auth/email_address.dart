import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';

part 'email_address.freezed.dart';

class EmailAddress {
  final Either<ValueFailure<String>, String> value;

  // Now to clean up all kinds of mess we use Either<Left, Right>,
  // to join our Valid Value and Failed Exception (if caught) in as single value.
  // we user Either<>, which takes 2 value. Left one isgenerally used for exceptions
  // Right one is generally used for correct values.
  // final Exception failure;

  const EmailAddress._(this.value);

  @override
  String toString() => 'EmailAddress($value)';

  // We have to create Value equality which is not by default in Dart.
  // What I mean by this is :
  // Suppose there are two instances of this class (EmailAddress)
  // which has the same 'value'. But in dart they won't be equal
  // Why? Because they both point to different locations in memory
  // and for Dart to consider them equal
  // they should point to the same location in memory.
  // Hence, we have to introduce ourselved to Value Equality.
  // i.e. if 2 instances have same value, they are equal.

  // Value Equality code BEGINS

  @override
  bool operator ==(Object o) {
    // condition if they refer to the same location in the memory.
    if (identical(this, o)) return true;

    // else if they are two different instances which have the same value,
    // hence, enforcing value equality.
    return o is EmailAddress && o.value == value;
  }

  // Value Equality code ENDS

  // Okay, now consider a case when someone tampers with the data in the Firestore DB
  // once the user has entered it and validated it.
  // We definitely, don't want that.

  // Hence, we want to validate the EmailAddress every time we use it, for this
  // we use factory constructor

  // for validating we'll run another logic which is ValidateEmail
  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  @override
  int get hashCode => value.hashCode;
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  String emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  // if the input email address is valid then we return the email address.
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  }
  // else if the email address entered by user is invalid, we can throw an exception
  // but we have to list every exception in try-catch and handle it in code.
  // what if we just store the FailedValue in the constructor itself?
  // but still we have to always include if checks whether the emailAddress.failure==null?
  // which is not appropriate.
  // So what we can do is we can join the email value and Failure/Exception in a
  // single value with the help of Union.
  // Hence, we use Either and store the failedValue and correct input in that.
  else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({required String failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.shortPassword({required String failedValue}) =
      ShortPassword<T>;
}
