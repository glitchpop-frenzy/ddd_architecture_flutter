import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';

import 'failures.dart';

@immutable
// This class is for EmailAddress and Password
// as it will be easier since both have some common properties
// therefore, it would be better to have a superclass
abstract class ValueObject<T> {
  Either<ValueFailure<T>, T> get value;

  // Now to clean up all kinds of mess we use Either<Left, Right>,
  // to join our Valid Value and Failed Exception (if caught) in as single value.
  // we user Either<>, which takes 2 value. Left one is generally used for exceptions
  // Right one is generally used for correct values.
  // final Exception failure;

  const ValueObject();
  // We have to create Value equality which is not by default in Dart.
  // What I mean by this is :
  // Suppose there are two instances of this class (ValueObject)
  // which has the same 'value'. But in dart they won't be equal
  // Why? Because they both point to different locations in memory
  // and for Dart to consider them equal
  // they should point to the same location in memory.
  // Hence, we have to introduce ourselved to Value Equality.
  // i.e. if 2 instances have same value, they are equal.

  // Value Equality code BEGINS

  @override
  bool operator ==(Object other) {
    // condition if they refer to the same location in the memory.
    if (identical(this, other)) return true;

    // else if they are two different instances which have the same value,
    // hence, enforcing value equality.
    return other is ValueObject<T> && other.value == value;
  }

  // Value Equality code ENDS

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
