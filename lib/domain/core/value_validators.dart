import 'package:dartz/dartz.dart';
import 'failures.dart';

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

// Similar to validateEmailAddress
Either<ValueFailure<String>, String> validatePassword(String input) {
  // if the input email address is valid then we return the email address.
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}
