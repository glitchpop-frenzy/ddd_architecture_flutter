// First we list down, what are the errors that can occur in auth flow
// and then assign a method to handle that particular failure.
// and we're gonna use freezed for the same

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  // 1. When the user taps out in the middle of Sign In procedure.
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  // 2. When there is error from the server side.
  const factory AuthFailure.serverError() = ServerError;
  // 3. When the user registers with an email that is already registered.
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  // 4. When the user enters an invalid combination of email and password.
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination;
}
