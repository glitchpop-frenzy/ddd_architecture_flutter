import 'package:dartz/dartz.dart';
import 'auth_failure.dart';
import 'value_objects.dart';

// This file will provide an interface for authentication
// b/w front-end and backend
// Facade : Facade is a design pattern
// which is used for connecting two or more weird design pattern
// and cannot be used in app directly
// into a nicely wrapped interface code.

// Facades are at the same level as repositories.
// They take up some raw data from data sources
// and also simplifying the surface of the contained class
// (GoogleSignIn and FirebaseAuth classes)

abstract class IAuthFacade {
  // Also, we don't want to catch exceptions from the authentication
  // in the application layer,
  // therefore we will use Either class and create an auth_failure.dart
  // for the same.

  // We can't use void since void isn't a class in Dart. It's just a keyword.
  // Therefore we use Unit.

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password});
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password});

  // sign-in with Google won't require us to have any parameters
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
