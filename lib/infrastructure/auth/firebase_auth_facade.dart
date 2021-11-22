import 'package:ddd_architecture_flutter/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_architecture_flutter/domain/auth/i_auth_facade.dart';
import 'package:ddd_architecture_flutter/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/auth/i_auth_facade.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    }
    // Now the error provided by FirebaseAuth Method
    // Invalid email and weak password are already handled
    // within our domain and won't be even able to enter this level.
    // Now, only email-already-in-use and operation-not-allowed
    // error can be shown and hence we'll handle that.
    on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final String emailAddressStr = password.getOrCrash();
    final String passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      // Google specific authentication
      final googleAuthentication = await googleUser.authentication;
      final googleAuthCred = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      return _firebaseAuth
          .signInWithCredential(googleAuthCred)
          .then((result) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
    // User not interested in such low level errors of signInWithCredentials
    // hence not presenting much specific error to the user.
  }
}
